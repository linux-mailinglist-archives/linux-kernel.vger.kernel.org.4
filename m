Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882C06BA2A7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjCNWmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjCNWl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:41:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B1C37541;
        Tue, 14 Mar 2023 15:41:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 318CF61A47;
        Tue, 14 Mar 2023 22:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A4DC433D2;
        Tue, 14 Mar 2023 22:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678833717;
        bh=s6IlrideidXiP2FRDZyepR6OUAPx5CL/GzNBpxy/lyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjWPkr1+9gglz/7YFCYrvIRAAcuskx48dxq6RXDQROZhnIya6h3HhSKYhE0nTSf5t
         OrXC260lip8lFK8+4Pm9XfjUAdmK58eimPvgXFXtDAkozgninx/vF7g2EusBBcikjH
         gPoES119tn804hA+3fXCBA3MZ7PDH92TbGrG28RmHkALJ9da/Qso8bLY1q1iRNxpXh
         IH/XHB5mZKXHqu+G+uCpIQTtHpZls1IF2YzARdSxW7ixG9Y1xj9Qxn/E3+TSCqI0W6
         a2RR35RzpZYeUWYjoOMaKOT/Ou0AioOTdSbonL+DM6YBjPaE87mt/2iF0NU79daUxN
         DylGDWdztvrbw==
Date:   Tue, 14 Mar 2023 23:41:54 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Andi Shyti <andi.shyti@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        lvc-project@linuxtesting.org,
        Kasumov Ruslan <xhxgldhlpfy@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-iio@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Kasumov Ruslan <s02210418@gse.cs.msu.ru>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [lvc-project] [PATCH] iio: adc: qcom-pm8xxx-xoadc: Remove
 useless condition in pm8xxx_xoadc_parse_channel()
Message-ID: <20230314224154.7gctfkt2mlaz3geg@intel.intel>
References: <20230314193709.15208-1-xhxgldhlpfy@gmail.com>
 <CACRpkdan0Vt_T3aRVAK4rd=hQV=MOARm9Wq7sD8rjoisTW6Dkw@mail.gmail.com>
 <20230314212851.hqbzs5hhed5apcv5@intel.intel>
 <9aec4249-6457-4e3b-13dd-baf02d4fbfad@ispras.ru>
 <CACRpkdb2CFckKo=VGb4gkyS0pXmqDrRBtJNeT1PjetctRquBVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdb2CFckKo=VGb4gkyS0pXmqDrRBtJNeT1PjetctRquBVQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey and Ruslan,

On Tue, Mar 14, 2023 at 11:07:19PM +0100, Linus Walleij wrote:
> On Tue, Mar 14, 2023 at 11:03 PM Alexey Khoroshilov
> <khoroshilov@ispras.ru> wrote:
> 
> > As far as I can see sentinel is an "empty" element of xoadc_channel in
> > the array, i.e. hwchan->datasheet_name works as a sentinel while hwchan
> > is always non NULL.
> 
> You're right, I was unable to understand my own code :(

At this time of the day I got alarmed too. Happens :)

Please ignore my previous comment but still no need for the
Fixes: tag from the commit log as it's a cleanup and not a bug
fix.

Thanks,
Andi
