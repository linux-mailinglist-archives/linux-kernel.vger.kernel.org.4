Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321D5690177
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBIHnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBIHm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:42:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECA1244AD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 23:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675928472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tBVnWOxZN0l6o+QuVuNWanJQCILIO8H7yQ/rQtmhRzc=;
        b=YKmtVutHCz5ZD+4lWbrqSzfIPu6BLDA2WczQdogTskYuqdZGXJD9iPkz8GqUKm55KH3FD1
        zBLnPbQipDQz2rjf9IZ60wYexkowSO4F012/n6vCSH05+GOMDPhKlbwQMAANe+8OcKwMN1
        fL3hovYbQC91Su3RNaIGY2VEvdfLsE8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-73-a3hqG-r7P-mWJq8UD7eu5w-1; Thu, 09 Feb 2023 02:41:10 -0500
X-MC-Unique: a3hqG-r7P-mWJq8UD7eu5w-1
Received: by mail-ej1-f71.google.com with SMTP id i11-20020a1709061ccb00b008aadd9cb12fso965666ejh.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 23:41:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBVnWOxZN0l6o+QuVuNWanJQCILIO8H7yQ/rQtmhRzc=;
        b=VAHPG9FbnvfAGiGZPcoYas2ZHwxWmic3N8fwGb20guwMjMBy8VzBhQ5esTul1ErxOo
         V/TdDui2NuVv/ksglry0zghBjqQiV1dn7j4ciy86335N2sesZr2SAc0Six95BWuUR1x/
         mnSIf3rKBIjPaRP/VO3Ms2VC6SJgIlHe/pHJaIfjl/bphk37FlSDy8GUUvvDw+lp239I
         igwOhF19kR+U2B38VEe9BjJvvLzDzs/roPXD+lgUJ4xIRkDU18ZTqbo3dwiO1rLyXhOh
         G48Bl0Ak+QY4CdJ7+0gJymicZvGcKi5FjHeuBYH+wE0/oULgfehsJS0AA4xvKm2CjPhU
         HjEQ==
X-Gm-Message-State: AO0yUKXN3HSZtVT+HU/2ObPFoCQQg7YQc+LoHL4q9T14XNvMoXLzWzge
        Me4AqhLL+ljKClNdy9Y7Um2ub0Ib1+WHpT25UD+GkUtMBHBbhhQqvAi1P8hPMJ4Tpae6FWOEOH0
        NRxXlHWtNC0T1TF4U/HRTv61h
X-Received: by 2002:a17:907:608b:b0:8aa:c105:f0bf with SMTP id ht11-20020a170907608b00b008aac105f0bfmr10478716ejc.17.1675928468886;
        Wed, 08 Feb 2023 23:41:08 -0800 (PST)
X-Google-Smtp-Source: AK7set9aH2PzEPPLo0YJUlnsK16u0uIVA5yC1U6lk43TVGarqiJIZI5lcQAf2CtyoaWTt+6rE9LS/w==
X-Received: by 2002:a17:907:608b:b0:8aa:c105:f0bf with SMTP id ht11-20020a170907608b00b008aac105f0bfmr10478695ejc.17.1675928468677;
        Wed, 08 Feb 2023 23:41:08 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id b15-20020a170906660f00b00871075bfcfesm515007ejp.133.2023.02.08.23.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 23:41:07 -0800 (PST)
Date:   Thu, 9 Feb 2023 02:41:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     qemu-devel@nongnu.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Eduardo Habkost <eduardo@habkost.net>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH RFC 5/7] Revert "x86: use typedef for SetupData struct"
Message-ID: <20230209024011-mutt-send-email-mst@kernel.org>
References: <20230208211212.41951-1-mst@redhat.com>
 <20230208211212.41951-6-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208211212.41951-6-mst@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 04:12:51PM -0500, Michael S. Tsirkin wrote:
> This reverts commit eebb38a5633a77f5fa79d6486d5b2fcf8fbe3c07.
> 
> Fixes: eebb38a563 ("x86: use typedef for SetupData struct")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


This one was actually good, I reverted so other reverts are clean.
Jason I would appreciate it if you can rebase this on top
of the revert.


> ---
>  hw/i386/x86.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 32f37ab7c2..76b12108b4 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -657,12 +657,12 @@ DeviceState *ioapic_init_secondary(GSIState *gsi_state)
>      return dev;
>  }
>  
> -typedef struct SetupData {
> +struct setup_data {
>      uint64_t next;
>      uint32_t type;
>      uint32_t len;
>      uint8_t data[];
> -} __attribute__((packed)) SetupData;
> +} __attribute__((packed));
>  
>  
>  /*
> @@ -803,7 +803,7 @@ void x86_load_linux(X86MachineState *x86ms,
>      FILE *f;
>      char *vmode;
>      MachineState *machine = MACHINE(x86ms);
> -    SetupData *setup_data;
> +    struct setup_data *setup_data;
>      const char *kernel_filename = machine->kernel_filename;
>      const char *initrd_filename = machine->initrd_filename;
>      const char *dtb_filename = machine->dtb;
> @@ -1086,11 +1086,11 @@ void x86_load_linux(X86MachineState *x86ms,
>          }
>  
>          setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
> -        kernel_size = setup_data_offset + sizeof(SetupData) + dtb_size;
> +        kernel_size = setup_data_offset + sizeof(struct setup_data) + dtb_size;
>          kernel = g_realloc(kernel, kernel_size);
>  
>  
> -        setup_data = (SetupData *)(kernel + setup_data_offset);
> +        setup_data = (struct setup_data *)(kernel + setup_data_offset);
>          setup_data->next = cpu_to_le64(first_setup_data);
>          first_setup_data = prot_addr + setup_data_offset;
>          setup_data->type = cpu_to_le32(SETUP_DTB);
> @@ -1101,9 +1101,9 @@ void x86_load_linux(X86MachineState *x86ms,
>  
>      if (!legacy_no_rng_seed) {
>          setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
> -        kernel_size = setup_data_offset + sizeof(SetupData) + RNG_SEED_LENGTH;
> +        kernel_size = setup_data_offset + sizeof(struct setup_data) + RNG_SEED_LENGTH;
>          kernel = g_realloc(kernel, kernel_size);
> -        setup_data = (SetupData *)(kernel + setup_data_offset);
> +        setup_data = (struct setup_data *)(kernel + setup_data_offset);
>          setup_data->next = cpu_to_le64(first_setup_data);
>          first_setup_data = prot_addr + setup_data_offset;
>          setup_data->type = cpu_to_le32(SETUP_RNG_SEED);
> -- 
> MST
> 

