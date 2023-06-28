Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121257411C2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjF1MvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjF1Mus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:50:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEF61FE8;
        Wed, 28 Jun 2023 05:50:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63725612B1;
        Wed, 28 Jun 2023 12:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1D1C433C8;
        Wed, 28 Jun 2023 12:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687956645;
        bh=84V8hGsuqZZKvhSwaACyOQ1VuM7UjHW/bRcJPu6bVmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+QBerWHiTCty0ZxlfZSYK+ZRGYFPgUjfh3RWw2dnFwDEf1MwBPFHlSiGqzG5+9tD
         sAJHFfAnSuO1J2dD22CzS4H77ny9LVD7JTxQ8c7KfUR/ALoivAQgj4UXDN6p4/rV4y
         iCSlbtQYETCmk9c2p4eBljj9e9F0mVsX1zfgwVcHn3avpOeM1MwnRoNhnlTygOFI1P
         PdBckP40cmh4Cs0mQAQdc7B/wLqy40Zn7NgjQBIEWA9JgKt2MsgqTNl5JE0siiCXzO
         VEDIe+pBY0uPhABho6R3yZ6M++YbKSH6zr1qjy/pWfS4Yh6qn7E/ArVMtJG4WgUxPK
         bF/0KVgO8u+xA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qEUdC-0007VB-4L; Wed, 28 Jun 2023 14:50:46 +0200
Date:   Wed, 28 Jun 2023 14:50:46 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] firmware: qcom_scm: Add support for Qualcomm
 Secure Execution Environment SCM interface
Message-ID: <ZJwspnWhpOCJ88WP@hovoldconsulting.com>
References: <20230528230351.168210-1-luzmaximilian@gmail.com>
 <20230528230351.168210-4-luzmaximilian@gmail.com>
 <ZJwjWoxm3GDkJ0cm@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJwjWoxm3GDkJ0cm@hovoldconsulting.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 02:11:07PM +0200, Johan Hovold wrote:
> On Mon, May 29, 2023 at 01:03:50AM +0200, Maximilian Luz wrote:

> > @@ -1496,6 +1903,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
> >  
> >  	__get_convention();
> >  
> > +	ret = qcom_scm_qseecom_init();
> > +	if (ret < 0) {
> > +		__scm = NULL;
> 
> So as I mentioned in my reply to 2/4, you can still have clients
> registered here when you clear the __scm pointer which they rely on
> after an error.
> 
> Not sure how best to handle this, but perhaps registering a qseecom
> platform device here and have it's driver probe defer until scm is
> available would work?
> 
> That way you could also separate out the qseecom implementation in a
> separate file (driver) rather than having the ifdef above.

An alternative may be to just warn and continue if
qcom_scm_qseecom_init() fails. It should never return -EPROBE_DEFER
anyway, right?

Johan
