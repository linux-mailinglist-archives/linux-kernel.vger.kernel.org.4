Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0186D248C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjCaP7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjCaP7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5353230F4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680278305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJdWf+C1H4WFOkVELieC/JAW8cI4Ny85dWN0l46/HX8=;
        b=hWeQpEj50iV+pECC5S1s32mMcyw0T4iZ3GEiO2qmEgoj2PpsCEM2m7mJf3h+Dh7X0dLaPO
        YymtmXHoL6l4iZ+9M6Zo3qv46vfAN3Dz3WvNLP7NhJlyDL8lh2PxzDLwGwRVMrc7/BhlW7
        voT9W502jCTGVbgsdwefeHiaSdL2ztQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-NqxOAigdOdSMhJrYcZOqzw-1; Fri, 31 Mar 2023 11:58:24 -0400
X-MC-Unique: NqxOAigdOdSMhJrYcZOqzw-1
Received: by mail-qt1-f199.google.com with SMTP id t15-20020a05622a180f00b003e37dd114e3so14878664qtc.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680278303;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJdWf+C1H4WFOkVELieC/JAW8cI4Ny85dWN0l46/HX8=;
        b=QiCt4ZZT+FnIeG/3LYLBXukWGWg5OfCnanWEJsVpeDtpZdQJkahB7toCAugHxEuQ3n
         bGaTs0RNmQJXzED/eS4ckS5g5CMG9/KLvJ1arXxbcq7/xV0Q/JFawhlBR4NJraPron5P
         7g6xc3D5hiPMTtj/x8wTCe4JLgKD2v+CEkdIomSdbZbKxtowSlqjyzfO3t23COlA2rtu
         rJW/UPDLq1F3Yvxh8RXaqm4qcqLYUjMQc5JzduVAnI5jB55hZjSdd5qrGoyef1hS2Zc+
         X+MfvyUdX7k8hwCZS1Ai0h/Rb5wGnV4KUQAcYkLHgTLKm+sXIRp2yIO5hio6m55u2HGu
         Htjw==
X-Gm-Message-State: AO0yUKUlOJGFBT3AVq2MZt7ibyZytfsalHuXsWrYweZYvQulnlXFdKB2
        j2cXRt5KrUWOZGiB3da/SjBDVAmH5unvqCkd6ICQlO757xa+1fPDo12oKNHi9cNSvv4AJKcM7G3
        hbdGsa0Z1IBduNAeyaaNXA9n5
X-Received: by 2002:ac8:5884:0:b0:3c0:3d0b:e433 with SMTP id t4-20020ac85884000000b003c03d0be433mr35596922qta.10.1680278303529;
        Fri, 31 Mar 2023 08:58:23 -0700 (PDT)
X-Google-Smtp-Source: AK7set9lAS57G/fztM3/8Ml5aym5cxLEs4YQ07OF5pcXIbIHI2+f3a2ZqY6QsbGQpXVR1E5SZKyiZw==
X-Received: by 2002:ac8:5884:0:b0:3c0:3d0b:e433 with SMTP id t4-20020ac85884000000b003c03d0be433mr35596904qta.10.1680278303274;
        Fri, 31 Mar 2023 08:58:23 -0700 (PDT)
Received: from [192.168.1.12] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id h6-20020ac85686000000b003d29e23e214sm692447qta.82.2023.03.31.08.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 08:58:22 -0700 (PDT)
Message-ID: <e37ff5de-f34c-bd86-be04-a21f82612a7e@redhat.com>
Date:   Fri, 31 Mar 2023 11:58:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <4ce29654-4e1e-4680-9c25-715823ff5e02@p183>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v7 00/10] livepatch: klp-convert tool
In-Reply-To: <4ce29654-4e1e-4680-9c25-715823ff5e02@p183>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 08:10, Alexey Dobriyan wrote:
> Joe Lawrence wrote:
>> +static int update_strtab(struct elf *elf)
>> +{
>>
>> +	buf = malloc(new_size);
>> +	if (!buf) {
>> +		WARN("malloc failed");
>> +		return -1;
>> +	}
>> +	memcpy(buf, (void *)strtab->data, orig_size);
> 
> This code is called realloc(). :-)
> 
>> +static int write_file(struct elf *elf, const char *file)
>> +{
>>
>> +	fd = creat(file, 0664);
>> +	e = elf_begin(fd, ELF_C_WRITE, NULL);
> 
> elf_end() doesn't close descriptor, so there is potentially corrupted
> data. There is no unlink() call if writes fail as well.
> 
>> +void elf_close(struct elf *elf)
>> +{
>> +
>> +	if (elf->fd > 0)
>> +		close(elf->fd);
> 
> Techically, it is "fd >= 0".
> 
>> +filechk_klp_map = \
>> +	echo "klp-convert-symbol-data.0.1";		\
>> +	echo "*vmlinux";				\
>> +	$(NM) -f posix vmlinux | cut -d\  -f1;		\
>> +	sort $(MODORDER) $(MODULES_LIVEPATCH) |		\
> 
> This probably should be "LC_ALL=C sort" for speed and reproducibility (?).
> 

Thanks, will incorporate these into the next version.

-- 
Joe

