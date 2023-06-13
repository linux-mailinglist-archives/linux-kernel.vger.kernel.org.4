Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9705C72D6A0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 02:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjFMAtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 20:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFMAtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 20:49:19 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4464210D3;
        Mon, 12 Jun 2023 17:49:18 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1152)
        id ACDC420FE86C; Mon, 12 Jun 2023 17:49:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ACDC420FE86C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686617357;
        bh=Tp1WzQdcx12W1fzBArAndkSd8SuQkzZ/5ksg+tQwJqs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Cz69bezj1h7WpyniLbBF79JtEUf+PZyKWL//KV4CS0zag0E+zewbtPPKGhuM5DCPR
         I+T8kVYutZi3ZltH+cHOdLHJ0D4KYmjQlRfeWhIbRcXSaN8jeQM86TZc/KySzKPMGs
         zhv8/1LsPyC+ovVB6Fd1J8TdQGwTmrqCghYEDXKs=
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id A98CB307032D;
        Mon, 12 Jun 2023 17:49:17 -0700 (PDT)
Date:   Mon, 12 Jun 2023 17:49:17 -0700 (PDT)
From:   Shyam Saini <shyamsaini@linux.microsoft.com>
To:     alex.bennee@linaro.org
cc:     Sumit Garg <sumit.garg@linaro.org>,
        "Zhu, Bing" <bing.zhu@intel.com>,
        "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
        "code@tyhicks.com" <code@tyhicks.com>,
        "Matti.Moell@opensynergy.com" <Matti.Moell@opensynergy.com>,
        "arnd@linaro.org" <arnd@linaro.org>,
        "hmo@opensynergy.com" <hmo@opensynergy.com>,
        "joakim.bech@linaro.org" <joakim.bech@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "maxim.uvarov@linaro.org" <maxim.uvarov@linaro.org>,
        "ruchika.gupta@linaro.org" <ruchika.gupta@linaro.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Huang, Yang" <yang.huang@intel.com>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        ilias.apalodimas@linaro.org
Subject: Re: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
In-Reply-To: <CAC_iWjLOhUvp5ggCCkHN5MRNfB_h6FZ2Z14yrtR3aqGn0Ovxig@mail.gmail.com>
Message-ID: <f078ddef-8654-4e18-fd1f-8b81f8f2aabd@linux.microsoft.com>
References: <20220405093759.1126835-1-alex.bennee@linaro.org> <20230531191007.13460-1-shyamsaini@linux.microsoft.com> <SN7PR11MB6850DA4A185E3429B62531CD84499@SN7PR11MB6850.namprd11.prod.outlook.com> <CAC_iWjKAdimEH0SsC_z9QuFS4sGLp2BVzx03s+RKvcLXY25kuQ@mail.gmail.com>
 <CAFA6WYPKeJYTzvnZkoL_dw6uXSkhAh6uxoEOWHYU7oLNRDRWaA@mail.gmail.com> <CAC_iWjLOhUvp5ggCCkHN5MRNfB_h6FZ2Z14yrtR3aqGn0Ovxig@mail.gmail.com>
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


Thank you everyone for your valueable feedback.

Alex, are you planning submit this patch series ?
Please let me know.

> On Thu, 1 Jun 2023 at 08:49, Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> On Thu, 1 Jun 2023 at 11:02, Ilias Apalodimas
>> <ilias.apalodimas@linaro.org> wrote:
>>>
>>> Hi Bing
>>>
>>> On Thu, 1 Jun 2023 at 04:03, Zhu, Bing <bing.zhu@intel.com> wrote:
>>>>
>>>> As an alternative, Is it possible to change ftpm design not to depend on RPMB access at the earlier/boot stage? Because to my understanding, typically PCRs don't require persistent/NV storage (for example, before RPMB or tee-supplicant is ready, use TEE memory instead as temporary storage)
>>>
>>> I am not entirely sure this will solve our problem here.  You are
>>> right that we shouldn't depend on the supplicant to extend PCRs. But
>>> what happens if an object is sealed against certain PCR values?  We
>>> are back to the same problem
>>
>> +1
>>
>> Temporary storage may be a stop gap solution for some use-cases but
>> having a fast path access to RPMB via kernel should be our final goal.
>> I would suggest we start small with the MMC subsystem to expose RPMB
>> access APIs for OP-TEE driver rather than a complete RPMB subsystem.
>
> I discussed with the OP-TEE maintainers about adding parts of the
> supplicant in the kernel.  The supplicant 'just' sends an ioctl to
> store/read stuff anyway.  So it would make sense to have a closer and
> see if that looks reasonable.
> Thanks
>
> /Ilias
>
>>
>> -Sumit
>>
>>>
>>> Thanks
>>> /Ilias
>>>>
>>>> Bing
>>>>
>>>> IPAS Security Brown Belt (https://www.credly.com/badges/69ea809f-3a96-4bc7-bb2f-442c1b17af26)
>>>> System Software Engineering
>>>> Software and Advanced Technology Group
>>>> Zizhu Science Park, Shanghai, China
>>>>
>>>> -----Original Message-----
>>>> From: Shyam Saini <shyamsaini@linux.microsoft.com>
>>>> Sent: Thursday, June 1, 2023 3:10 AM
>>>> To: alex.bennee@linaro.org
>>>> Cc: code@tyhicks.com; Matti.Moell@opensynergy.com; arnd@linaro.org; Zhu, Bing <bing.zhu@intel.com>; hmo@opensynergy.com; ilias.apalodimas@linaro.org; joakim.bech@linaro.org; linux-kernel@vger.kernel.org; linux-mmc@vger.kernel.org; linux-scsi@vger.kernel.org; maxim.uvarov@linaro.org; ruchika.gupta@linaro.org; Winkler, Tomas <tomas.winkler@intel.com>; ulf.hansson@linaro.org; Huang, Yang <yang.huang@intel.com>; sumit.garg@linaro.org; jens.wiklander@linaro.org; op-tee@lists.trustedfirmware.org
>>>> Subject: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
>>>>
>>>> Hi Alex,
>>>>
>>>> [ Resending, Sorry for the noise ]
>>>>
>>>> Are you still working on it or planning to resubmit it ?
>>>>
>>>> [1] The current optee tee kernel driver implementation doesn't work when IMA is used with optee implemented ftpm.
>>>>
>>>> The ftpm has dependency on tee-supplicant which comes once the user space is up and running and IMA attestation happens at boot time and it requires to extend ftpm PCRs.
>>>>
>>>> But IMA can't use PCRs if ftpm use secure emmc RPMB partition. As optee can only access RPMB via tee-supplicant(user space). So, there should be a fast path to allow optee os to access the RPMB parititon without waiting for user-space tee supplicant.
>>>>
>>>> To achieve this fast path linux optee driver and mmc driver needs some work and finally it will need RPMB driver which you posted.
>>>>
>>>> Please let me know what's your plan on this.
>>>>
>>>> [1] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html
>>>>
>>>> Best Regards,
>>>> Shyam
>
