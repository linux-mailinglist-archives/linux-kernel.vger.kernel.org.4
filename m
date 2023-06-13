Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695C772E8CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjFMQrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbjFMQrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:47:46 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C18219BC;
        Tue, 13 Jun 2023 09:47:44 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1152)
        id E94B720FE6E9; Tue, 13 Jun 2023 09:47:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E94B720FE6E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686674863;
        bh=+iEeguyuJXlRkQExInBQoHnknosojavZvT0L/jXtsK8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=nbWg7k0es9g6uyWIXPbwVTVmxCFAbr+YJ8FFRgAk2NWCqeZbo1IPKlsy5zotIOxrh
         Nse1nuyT4dDPmP3OSYW2EwEiLLpNHjm2m/R0lsZwZmUJZz2KHbG5UhTFbu3RS2y8kJ
         PUSZfnpB7ZXTdrArVD6nAf2ecJpOeCijnR3kb7DY=
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id E6305307057C;
        Tue, 13 Jun 2023 09:47:43 -0700 (PDT)
Date:   Tue, 13 Jun 2023 09:47:43 -0700 (PDT)
From:   Shyam Saini <shyamsaini@linux.microsoft.com>
To:     "Zhu, Bing" <bing.zhu@intel.com>
cc:     "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
        "code@tyhicks.com" <code@tyhicks.com>,
        "Matti.Moell@opensynergy.com" <Matti.Moell@opensynergy.com>,
        "arnd@linaro.org" <arnd@linaro.org>,
        "hmo@opensynergy.com" <hmo@opensynergy.com>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        "joakim.bech@linaro.org" <joakim.bech@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "maxim.uvarov@linaro.org" <maxim.uvarov@linaro.org>,
        "ruchika.gupta@linaro.org" <ruchika.gupta@linaro.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Huang, Yang" <yang.huang@intel.com>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Subject: RE: [PATCH  v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
In-Reply-To: <SN7PR11MB6850DA4A185E3429B62531CD84499@SN7PR11MB6850.namprd11.prod.outlook.com>
Message-ID: <1ee57e46-6e86-eff0-ba9e-b7526fa865c0@linux.microsoft.com>
References: <20220405093759.1126835-1-alex.bennee@linaro.org> <20230531191007.13460-1-shyamsaini@linux.microsoft.com> <SN7PR11MB6850DA4A185E3429B62531CD84499@SN7PR11MB6850.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bing,

Other than PCRs we also want to store Non volatile ftpm data (NVData), 
storing these in volatile DDR shared memory will be a spec violation.

Best Regards,
Shyam

> As an alternative, Is it possible to change ftpm design not to depend on RPMB access at the earlier/boot stage? Because to my understanding, typically PCRs don't require persistent/NV storage (for example, before RPMB or tee-supplicant is ready, use TEE memory instead as temporary storage)
>
> Bing
>
> IPAS Security Brown Belt (https://www.credly.com/badges/69ea809f-3a96-4bc7-bb2f-442c1b17af26)
> System Software Engineering
> Software and Advanced Technology Group
> Zizhu Science Park, Shanghai, China
>
> -----Original Message-----
> From: Shyam Saini <shyamsaini@linux.microsoft.com>
> Sent: Thursday, June 1, 2023 3:10 AM
> To: alex.bennee@linaro.org
> Cc: code@tyhicks.com; Matti.Moell@opensynergy.com; arnd@linaro.org; Zhu, Bing <bing.zhu@intel.com>; hmo@opensynergy.com; ilias.apalodimas@linaro.org; joakim.bech@linaro.org; linux-kernel@vger.kernel.org; linux-mmc@vger.kernel.org; linux-scsi@vger.kernel.org; maxim.uvarov@linaro.org; ruchika.gupta@linaro.org; Winkler, Tomas <tomas.winkler@intel.com>; ulf.hansson@linaro.org; Huang, Yang <yang.huang@intel.com>; sumit.garg@linaro.org; jens.wiklander@linaro.org; op-tee@lists.trustedfirmware.org
> Subject: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
>
> Hi Alex,
>
> [ Resending, Sorry for the noise ]
>
> Are you still working on it or planning to resubmit it ?
>
> [1] The current optee tee kernel driver implementation doesn't work when IMA is used with optee implemented ftpm.
>
> The ftpm has dependency on tee-supplicant which comes once the user space is up and running and IMA attestation happens at boot time and it requires to extend ftpm PCRs.
>
> But IMA can't use PCRs if ftpm use secure emmc RPMB partition. As optee can only access RPMB via tee-supplicant(user space). So, there should be a fast path to allow optee os to access the RPMB parititon without waiting for user-space tee supplicant.
>
> To achieve this fast path linux optee driver and mmc driver needs some work and finally it will need RPMB driver which you posted.
>
> Please let me know what's your plan on this.
>
> [1] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html
>
> Best Regards,
> Shyam
>
