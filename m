Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFED6A6ED1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjCAOvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCAOvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:51:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CB7392A1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677682251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nibQL9J+s7T5DlxV2x+HGNXQnlc+nTXrLjoLaVjKiHg=;
        b=c4tOgvGa5iv48I4JZKZ4vu+STkIiWumUzM9xHMzO5XaZDawR2YCG+tSQWWnJZMqSKGYOgB
        0Ci/Y1dYvU6hm70muOD3F/x0F9330JoiSpJWT7LmpS3jfJ1eX9if3t+xSuQ/3mFBN4BCOC
        8VUtz/Yf32byWKejs2/sboODpv0xfbc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-558-RS38qgNnNIOWdxHrKLyMIQ-1; Wed, 01 Mar 2023 09:48:44 -0500
X-MC-Unique: RS38qgNnNIOWdxHrKLyMIQ-1
Received: by mail-ed1-f72.google.com with SMTP id eg35-20020a05640228a300b004ad6e399b73so19460231edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 06:48:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nibQL9J+s7T5DlxV2x+HGNXQnlc+nTXrLjoLaVjKiHg=;
        b=WogOysZJfvkhJGEMiDaU5JyXZYibfd/X8dMsINLb/KowBYpin9OkRuwFAnAIPQDVfU
         DqazzvNU0Th0pnkoASDJA3p9igGSdUHFlXDwjvVsXHjO698kQHd0kdmPjKqexh0jUbrv
         sCwnRdb8mdYf/4oUnpUzLpwbPAJjIbMq71TSBZBVAkI+jMvcSq1skLrD+YFkT8qzckeb
         bXgui18uNIVLqhpFy6lXHYT8Pfmeh2h8AqQ90nzL7b1vWcwXlZ9cFYhh9atvvBmF958G
         +9PNp+utVcCsebw9rbTaAzkarZuZd36dYfgJsEUpxBjKtSVI+olTNHSxKZRdd/J7PB0Y
         mPjg==
X-Gm-Message-State: AO0yUKVLbAKEjFQKpLc4U5j9OGt+9zXRiAz+PXbq6zwbIzzIClpfWOgR
        A28R1to1ohxLtNy1g9AZmbHm5v9vxEhpO35vp8I1lwRPuFf314ZamaYkUKKYXh2hJ6y9bppzGWn
        9atBUcuUigypFdpyyHFhL2s2Y
X-Received: by 2002:a17:907:961f:b0:8b2:3eb6:8658 with SMTP id gb31-20020a170907961f00b008b23eb68658mr9464795ejc.0.1677682122630;
        Wed, 01 Mar 2023 06:48:42 -0800 (PST)
X-Google-Smtp-Source: AK7set92dBt8bcH0u8SZUcg7fEaeb3iC2XcaTDRsF3gZiSF9OJlHicCTVfXkqbC2EWAO2040o+eR1g==
X-Received: by 2002:a17:907:961f:b0:8b2:3eb6:8658 with SMTP id gb31-20020a170907961f00b008b23eb68658mr9464766ejc.0.1677682122307;
        Wed, 01 Mar 2023 06:48:42 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b008d356cafaedsm5740721ejd.40.2023.03.01.06.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 06:48:41 -0800 (PST)
Message-ID: <2fb62d68-7414-64e2-a425-8cfaab23bcc5@redhat.com>
Date:   Wed, 1 Mar 2023 15:48:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 01/12] platform/x86: ISST: Fix kernel documentation
 warnings
Content-Language: en-US, nl
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
 <20230211063257.311746-2-srinivas.pandruvada@linux.intel.com>
 <39b98cb1-1ef5-dabf-5f01-2f673b2b59b1@redhat.com>
 <bc3ad416cf45aa1e8fe1f466a09a9388b0aaf7ab.camel@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <bc3ad416cf45aa1e8fe1f466a09a9388b0aaf7ab.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/1/23 15:48, srinivas pandruvada wrote:
> Hi Hans,
> 
> Since some patches you are adding to your review branch,
> shall I exclude those from new series by rebasing on 
> your review-hans branch?
> ?

Yes please rebase on my review-hans branch.

Regards,

Hans



> On Wed, 2023-03-01 at 15:23 +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 2/11/23 07:32, Srinivas Pandruvada wrote:
>>> Fix warning displayed for "make W=1" for kernel documentation.
>>>
>>> Signed-off-by: Srinivas Pandruvada
>>> <srinivas.pandruvada@linux.intel.com>
>>
>> Thanks, I've applied this patch to my review-hans branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>>
>> I'll rebase that branch once 6.3-rc1 is out and then push the rebased
>> patch to the fixes branch and include it in my next 6.3 fixes pull-
>> req
>> to Linus.
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>
>>> ---
>>>  drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 3
>>> ++-
>>>  drivers/platform/x86/intel/speed_select_if/isst_if_common.h | 1 +
>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git
>>> a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>>> b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>>> index a7e02b24a87a..63d49fe17a16 100644
>>> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>>> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>>> @@ -112,6 +112,7 @@ static void isst_delete_hash(void)
>>>   * isst_store_cmd() - Store command to a hash table
>>>   * @cmd: Mailbox command.
>>>   * @sub_cmd: Mailbox sub-command or MSR id.
>>> + * @cpu: Target CPU for the command
>>>   * @mbox_cmd_type: Mailbox or MSR command.
>>>   * @param: Mailbox parameter.
>>>   * @data: Mailbox request data or MSR data.
>>> @@ -363,7 +364,7 @@ static struct pci_dev *_isst_if_get_pci_dev(int
>>> cpu, int bus_no, int dev, int fn
>>>  /**
>>>   * isst_if_get_pci_dev() - Get the PCI device instance for a CPU
>>>   * @cpu: Logical CPU number.
>>> - * @bus_number: The bus number assigned by the hardware.
>>> + * @bus_no: The bus number assigned by the hardware.
>>>   * @dev: The device number assigned by the hardware.
>>>   * @fn: The function number assigned by the hardware.
>>>   *
>>> diff --git
>>> a/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
>>> b/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
>>> index fdecdae248d7..35ff506b402e 100644
>>> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
>>> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
>>> @@ -40,6 +40,7 @@
>>>   * @offset:    Offset to the first valid member in command
>>> structure.
>>>   *             This will be the offset of the start of the command
>>>   *             after command count field
>>> + * @owner:     Registered module owner
>>>   * @cmd_callback: Callback function to handle IOCTL. The callback
>>> has the
>>>   *             command pointer with data for command. There is a
>>> pointer
>>>   *             called write_only, which when set, will not copy
>>> the
>>
> 

