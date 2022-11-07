Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77C661F1C9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiKGL0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiKGL0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:26:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000A3BC7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667820335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dCVCpPKMqtN5wnk1UeEtAp45DPD5WDdi+08rU7HtVp0=;
        b=K9BKU0x3EslvbNoYfThNTZk70nyufgLxXg2rEssxhQsW/fBBdTkRqGdRFHKNodRSX4h5fq
        KZaOV/CEB7dqCRlSABoGcuKH9Erx1WaJn9yppXv27fIgo9bbF5SFsW+EF/CrmZ5JHD4R24
        sQSStRIO+z8YdjWX6mLYVcF8hKsMKH8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-614-V-s-3JDEP-OVhiNxZuCB1g-1; Mon, 07 Nov 2022 06:25:34 -0500
X-MC-Unique: V-s-3JDEP-OVhiNxZuCB1g-1
Received: by mail-pj1-f70.google.com with SMTP id ci1-20020a17090afc8100b00212e5b4c3afso4456740pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 03:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCVCpPKMqtN5wnk1UeEtAp45DPD5WDdi+08rU7HtVp0=;
        b=RBPpyVPGlJKlZqyAielmIOolVzrHlf+mYZzyVyTTp2JIIVk4V77oAVJcsKlXBJMt7i
         5hXrczTSOX44kY9WbryDHHw6jC8Odq49DpOZWIJX/EC1suMbdZE3jMOP00xFiXlIdly4
         CGKS95fkV5b3ZPTxpm/m4RtS32uwMXI4PgrxACameFeXU2b9MDxFfr4P6ML0JnF5MW6k
         oXpyC5OL9kHu6fKrj9PAOti7nFFtqc2MZ/ZrLgGC7wMlA56jIy75jm5bxGRV6OXwcwcC
         Y/LN8jONZ+PHYmkcQvZqWoAM95r/GDueayfS8dTCTJfo98u6dO5eL3XUDFa8F78eHoF5
         ZSwQ==
X-Gm-Message-State: ACrzQf1lOEnG3qK/W2Fa1FT0NOi0uhyuj6skcLn8IR5q61V04u8kB8mu
        Kw5dmXsJuQjxOk/9iSI62CKu4IXdmo9xLmZd+3E5u1rI1+iWHCbaSHFPeWC9Yccjiwf98fued3W
        OEbhf/pbn7nEnvlp1vx6yBnXQ
X-Received: by 2002:a17:90b:378a:b0:213:803d:3389 with SMTP id mz10-20020a17090b378a00b00213803d3389mr59863675pjb.115.1667820333148;
        Mon, 07 Nov 2022 03:25:33 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4kRlWD2TrlfQwcFjYkARJTFCe1a+ZyHxdAcDHlQVxS+84+J4PGUG5doWP7ysunIg0QVPRwjw==
X-Received: by 2002:a17:90b:378a:b0:213:803d:3389 with SMTP id mz10-20020a17090b378a00b00213803d3389mr59863627pjb.115.1667820332821;
        Mon, 07 Nov 2022 03:25:32 -0800 (PST)
Received: from localhost ([240e:3a1:313:8350:fe71:9f84:6361:a65b])
        by smtp.gmail.com with ESMTPSA id y1-20020aa78f21000000b005613220346asm4210353pfr.205.2022.11.07.03.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 03:25:32 -0800 (PST)
Date:   Mon, 7 Nov 2022 19:20:34 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     kexec@lists.infradead.org, Milan Broz <gmazyland@gmail.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Jan Pazdziora <jpazdziora@redhat.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC v2 4/5] x86/crash: make the page that stores the LUKS
 volume key inaccessible
Message-ID: <20221107112034.dxfembsprd2wwnpf@Rk>
References: <20221104113000.487098-1-coxu@redhat.com>
 <20221104113000.487098-5-coxu@redhat.com>
 <1c9a1b86-efef-fa56-4451-ac3348b678bf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1c9a1b86-efef-fa56-4451-ac3348b678bf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Thanks for the quick review!

On Fri, Nov 04, 2022 at 07:38:17AM -0700, Dave Hansen wrote:
>On 11/4/22 04:29, Coiby Xu wrote:
>> +	if (kexec_crash_image->luks_volume_key_addr) {
>> +		start = kexec_crash_image->luks_volume_key_addr;
>> +		end = start + kexec_crash_image->luks_volume_key_sz - 1;
>> +		page = pfn_to_page(start >> PAGE_SHIFT);
>> +		nr_pages = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;
>> +		set_memory_np((unsigned long)page_address(page), nr_pages);
>> +	}
>
>Why does this go pfn -> page -> vaddr?  What good does having the page
>do? 

Sorry it's an imitation of kexec_mark_crashkres.

> Can you just do phys_to_virt() on the start address?  Maybe:
>
> 	start_paddr = kexec_crash_image->luks_volume_key_addr;
> 	end_paddr   = start_paddr + kexec_crash_image->luks_volume_key_sz - 1;
> 	nr_pages = (PAGE_ALIGN(end_paddr) - PAGE_ALIGN_DOWN(start_paddr))/
>PAGE_SIZE;
> 	set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);

Thanks for suggesting a smarter implementation! I'll apply it to next
version.

>
>Also, if you resend this, please just cc the x86 folks on the series.
>The other patches and cover letter have desperately needed context
>around this.

Sure, I'll cc the x86 list the complete patch set next time. Sorry
you'll have to go to
https://lore.kernel.org/lkml/20221104113000.487098-5-coxu@redhat.com/t/
to read related emails for now.


>

-- 
Best regards,
Coiby

