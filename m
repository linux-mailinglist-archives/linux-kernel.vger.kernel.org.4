Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779566CA554
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjC0NN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0NN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:13:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBB81723
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:13:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id er18so24777010edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1679922835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2hTLfCHt4q1rmIa0nF5oelebRxyIA5+sHLWWs1PYjXM=;
        b=CuQjz2FLPaS4vlw1Cb7tuPhMrkpvuMTQJ193c2HarNDo/8AcWJ/H8jP7gwPvFG+PyZ
         JUIZbcLr0R3rvf46XBeKK00CC9sgi96Z4eSkzXZlWZxqM+0c4EjImQb0ris2cHY9FOh2
         Ca+OptDswIpIj5oYBXBJUKXLhpiYF3w3ttdyIuc/yBWYGU7kGNlFhjxRPOzNtef3MGhe
         I//xb+rgC7AX8kWn9z5Bg5J0Bc6fuosxrbFcWJEvFzv1pYhfnbEiI6x3F330lAV0cCUx
         SAfxGdnT32ZwLwAIg4MM/xiDbaZBF0/YTvsJnBWC427ixT3I/fYfGidFpALbzHAILz9m
         fU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679922835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hTLfCHt4q1rmIa0nF5oelebRxyIA5+sHLWWs1PYjXM=;
        b=Zw1BPnhPJlpdICwIznmLAS2E72kcRTgjKE9genNIeK5N2gXetu+7RLI+YEPOPKrR16
         pkBj9bM/AgZ9Oaolwi0cOcYZoKsuwoaiRYKpECaT8SVG8bxAkK7+gTSWa92F7Lm5Gstq
         IeoyswBrQ/APWJliYkqxsYa5T8UcNoFkWlyaW2EEEhwGjx6jrxMSKe00TVrlCEVIIkJh
         c4m7gFWm3oMS2rO99wc88iKtXPiqv5h50nEBNvH8geRwTHGTjjS6a2S01aDZWeWiEy+C
         ObItwR2Q39CWs5hSXTqf35r7jUgD/4ur3a146kMHE3qCAvnes0DIWsf/LRcbMgh0zZbt
         NkWA==
X-Gm-Message-State: AAQBX9dIfTkSjn2MEkzzd+c5ngCU6uAdzv+t1A/1oQQ0hU8Ruhw1ueR7
        MNjCPavAhzMHT54vnAqdD570JA==
X-Google-Smtp-Source: AKy350aDa+84QM+pYQ87GYnDIhdrXIpsIiIZhOXfntgDTSSl36wpDNmujFVf2xBx2x86Pd1USa34ZA==
X-Received: by 2002:a17:906:d051:b0:928:d4f6:6f77 with SMTP id bo17-20020a170906d05100b00928d4f66f77mr13042642ejb.29.1679922834804;
        Mon, 27 Mar 2023 06:13:54 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906248700b0093408d33875sm11267280ejb.49.2023.03.27.06.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:13:54 -0700 (PDT)
Date:   Mon, 27 Mar 2023 15:13:53 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com
Subject: Re: [PATCH v7 0/4] RISC-V Hibernation Support
Message-ID: <20230327131353.6gzjjppfy2o5456x@orel>
References: <20230323045604.536099-1-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323045604.536099-1-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:56:00PM +0800, Sia Jee Heng wrote:
> This series adds RISC-V Hibernation/suspend to disk support.
> Low level Arch functions were created to support hibernation.
> swsusp_arch_suspend() relies code from __cpu_suspend_enter() to write
> cpu state onto the stack, then calling swsusp_save() to save the memory
> image.
> 
> Arch specific hibernation header is implemented and is utilized by the
> arch_hibernation_header_restore() and arch_hibernation_header_save()
> functions. The arch specific hibernation header consists of satp, hartid,
> and the cpu_resume address. The kernel built version is also need to be
> saved into the hibernation image header to making sure only the same
> kernel is restore when resume.
> 
> swsusp_arch_resume() creates a temporary page table that covering only
> the linear map. It copies the restore code to a 'safe' page, then start to
> restore the memory image. Once completed, it restores the original
> kernel's page table. It then calls into __hibernate_cpu_resume()
> to restore the CPU context. Finally, it follows the normal hibernation
> path back to the hibernation core.
> 
> To enable hibernation/suspend to disk into RISCV, the below config
> need to be enabled:
> - CONFIG_ARCH_HIBERNATION_HEADER
> - CONFIG_ARCH_HIBERNATION_POSSIBLE
> 
> At high-level, this series includes the following changes:
> 1) Change suspend_save_csrs() and suspend_restore_csrs()
>    to public function as these functions are common to
>    suspend/hibernation. (patch 1)
> 2) Refactor the common code in the __cpu_resume_enter() function and
>    __hibernate_cpu_resume() function. The common code are used by
>    hibernation and suspend. (patch 2)
> 3) Enhance kernel_page_present() function to support huge page. (patch 3)
> 4) Add arch/riscv low level functions to support
>    hibernation/suspend to disk. (patch 4)
> 
> The above patches are based on kernel v6.3-rc3 and are tested on
> StarFive VF2 SBC board and Qemu. 
> ACPI platform mode is not supported in this series.
>

I tested this on QEMU, but, FYI, I had to use a raw backing file for
the swap disk, rather than a qcow2 backing file, otherwise it didn't
resume. It's probably worth looking into why that is.

Thanks,
drew
