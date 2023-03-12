Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033756B67A4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 16:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCLPs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 11:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCLPsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 11:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A3725BAF;
        Sun, 12 Mar 2023 08:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0509B60F58;
        Sun, 12 Mar 2023 15:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C424FC433EF;
        Sun, 12 Mar 2023 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678636103;
        bh=4ynmKhUuAz2hKEQnzcy3cI03Bw/bBNkKxDA10z/i6GE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IRyP/4Fr7CG4bgXsA10QTpWdxlJ9mfNajsT/0z4fDg8zLHnJYYeS8Xbu/9rcPTyI+
         jRtHR1lyk4O8gwyRmOvILlmQm4/Sg1K6CKci0iFpMl7kgI8btkT1adOA0YQms1FQis
         9+g5ErTArvs+c2r4UHrsB1ql4fl71HJ8UcbD2SS85d7V74SOrrghVs7roSJE5S1j8/
         dusOXxwx5D84Ltk3xYN0vhqUxVGhY94SMLhYSSty5og9eahgg0I0HctCYmCt+N8C+W
         20D5bDMOWlTuMAq6plbVuf4v4JQq1RU7CWYgyuksJqJzpyAG3GY7M/HFO3nr6vJVdi
         v9QQ75tvr80GA==
Date:   Sun, 12 Mar 2023 15:48:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 0/2] iio: ad74413r: allow setting sink current for
 digital input
Message-ID: <20230312154828.36b8e86b@jic23-huawei>
In-Reply-To: <20230306094301.1357543-1-linux@rasmusvillemoes.dk>
References: <20230302134922.1120217-1-linux@rasmusvillemoes.dk>
        <20230306094301.1357543-1-linux@rasmusvillemoes.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Mar 2023 10:42:59 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> Depending on the actual hardware wired up to a digital input channel,
> it may be necessary to configure the ad74413r to sink a small
> current. For example, in the case of a simple mechanical switch, the
> charge on the external 68 nF capacitor (cf. the data sheet's Figure
> 34) will keep the channel as reading high even after the switch is
> turned off again.
> 
> Add a DT binding and driver support for setting the desired sink current.
> 
> I have chosen the term "drive strength" because it matches existing
> practice, even if this is only a sink. E.g. there's
> 
>  * @PIN_CONFIG_DRIVE_STRENGTH_UA: the pin will sink or source at most the current
>  *      passed as argument. The argument is in uA.
> 
> and indeed it would be trivial to hook up that
> PIN_CONFIG_DRIVE_STRENGTH_UA in ad74413r_gpio_set_comp_config().
> 
> However, unlike the debounce time, there does not appear to be any way
> to actually tweak the drive strength from userspace, nor do I know if
> that would actually be a good idea. For our application(s), the
> current sink needed is a property of the attached hardware, and thus
> can and should be defined in DT.
> 
> v2:
> - remove redundant type info in binding per Rob's bot
> - use min() instead of if() in ad74413r_set_comp_drive_strength() per Jonathan
> 
> Rasmus Villemoes (2):
>   dt-bindings: iio: ad74413r: allow setting sink current for digital
>     input
>   iio: ad74413r: wire up support for drive-strength-microamp property
> 
>  .../bindings/iio/addac/adi,ad74413r.yaml      |  9 ++++++++
>  drivers/iio/addac/ad74413r.c                  | 23 +++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
Series applied to the togreg branch of iio.git and pushed out as testing
for 0-day to take a first look at it.

Thanks,

Jonathan

