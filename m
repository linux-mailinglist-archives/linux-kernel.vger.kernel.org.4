Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0C86AABE5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 19:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjCDSgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 13:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDSgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 13:36:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDBE1043E;
        Sat,  4 Mar 2023 10:36:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B234B80861;
        Sat,  4 Mar 2023 18:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E908C433D2;
        Sat,  4 Mar 2023 18:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677954963;
        bh=nmOOQLHOiz7gJf5KiKJT2S4NsQF0YRA9zYaeEfQ/Fig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lwHymCTciZYGvv9xb0dxF5gqsxfvHsJH6/1eqI3NaxhtgS9mX6JFVAg24jNZcglzn
         7FY87XzMjPZuYAulADE+EYbKBCM+2e5aR+uwXnxa30jHFE5Z3LCqpPIHJJqNvjD64w
         YmjATLPHhnjTJXeZqWwqupI7OuG3Du8uJii8uMQyEA9NHMQ4IQaVsgtmXrm+83UlD4
         7RN+RG9Jc7w2jXuyjg9EuL1/4f03lulkCeaq44gT0xMAcyMjbO2LKjib9Wlqf+u9gw
         B31MmlThnB329/8fkuHVWWQ59nlz+VYmvIZw3kcFKf4JNqxsenai5TX21fVwwv9GRv
         xCCEuQQe8mbtw==
Date:   Sat, 4 Mar 2023 18:35:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <20230304183557.2ea54737@jic23-huawei>
In-Reply-To: <9895826669118a1aa1db3f85c2610fa759426c33.1677750859.git.mazziesaccount@gmail.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
        <9895826669118a1aa1db3f85c2610fa759426c33.1677750859.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 12:57:54 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Some light sensors can adjust both the HW-gain and integration time.
> There are cases where adjusting the integration time has similar impact
> to the scale of the reported values as gain setting has.
> 
> IIO users do typically expect to handle scale by a single writable 'scale'
> entry. Driver should then adjust the gain/time accordingly.
> 
> It however is difficult for a driver to know whether it should change
> gain or integration time to meet the requested scale. Usually it is
> preferred to have longer integration time which usually improves
> accuracy, but there may be use-cases where long measurement times can be
> an issue. Thus it can be preferable to allow also changing the
> integration time - but mitigate the scale impact by also changing the gain
> underneath. Eg, if integration time change doubles the measured values,
> the driver can reduce the HW-gain to half.
> 
> The theory of the computations of gain-time-scale is simple. However,
> some people (undersigned) got that implemented wrong for more than once.
> 
> Add some gain-time-scale helpers in order to not dublicate errors in all
> drivers needing these computations.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Probably makes sense to put the exports in their own namespace.

I've been meaning to finish namespacing the rest of IIO but not
gotten around to it yet.
As this is a separate library probably makes sense to have a unique
namespace for it that the users opt in on.
Perhaps IIO_GTS makes sense?

Otherwise, as Andy's done a detailed review of this version I'll let
you update it for those comments and take another look at v3.

Thanks,

Jonathan


