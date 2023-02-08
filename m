Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C15468F821
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjBHTe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjBHTe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:34:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF7C4672F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:34:25 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318JKVKR002381;
        Wed, 8 Feb 2023 19:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZMc3ZlyMB9mIAnjxGHMKw3mxxSXYfbBTJu+cQHP0/Ak=;
 b=RHKsE0OTwmj7CDgJAXJIApuheetIdu3CQvbb9tFkUZ6jcHkWj4WiNgA/bKOCbRYkdOIe
 4P67qSFLfY9sl/du5ZR0JXggrndpjVGIDswF4vHP7hbh4mbhLsIvl/4ScQFzeN6u1COS
 dwk2Jr8IVpYZLXMOmkHebkK9WaQmIu7GSdABj7hUqgbhoA3rIbgyJ2DujfOxqGOapuje
 IY2SGKWuhufQo0XubRRnqYX3EB5sG9kk/HsIZ3YNg9m4Y93NwnmaK0uhoCagHomrSH+D
 /J1V7MvzWJzvLrpVxSkE4++4avZvqjdFCPFg+c3EIYClZUohfXFTOsWA3O/BEMgz5iiR 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmhteg9ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 19:34:11 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 318JXlrU024546;
        Wed, 8 Feb 2023 19:34:10 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmhteg9k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 19:34:10 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 318J8QQb003488;
        Wed, 8 Feb 2023 19:34:08 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3nhf07ev81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 19:34:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 318JY7tL9765422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Feb 2023 19:34:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 286C858066;
        Wed,  8 Feb 2023 19:34:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B03258052;
        Wed,  8 Feb 2023 19:34:03 +0000 (GMT)
Received: from [9.160.93.69] (unknown [9.160.93.69])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Feb 2023 19:34:02 +0000 (GMT)
Message-ID: <d0f667e9-c2dc-0868-9def-29bc3dac366f@linux.ibm.com>
Date:   Wed, 8 Feb 2023 21:34:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86: temporarily remove all attempts to provide
 setup_data
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, qemu-devel@nongnu.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Dov Murik <dovmurik@linux.ibm.com>
References: <20230208180835.234638-1-Jason@zx2c4.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <20230208180835.234638-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mDdYemSZklRZVRdyNvKpmBlisq2mUJvk
X-Proofpoint-ORIG-GUID: Di04OQrOFfsJMjwpmFZLra4bgNW6saGq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080167
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/02/2023 20:08, Jason A. Donenfeld wrote:
> All attempts at providing setup_data have been made as an iteration on
> whatever was there before, stretching back to the original
> implementation used for DTBs that [mis]used the kernel image itself.
> We've now had a dozen rounds of bugs and hacks, and the result is
> turning into a pile of unmaintainable and increasingly brittle hacks.
> 
> Let's just rip out all the madness and start over. We can re-architect
> this based on having a separate standalone setup_data file, which is how
> it should have been done in the first place. This is a larger project
> with a few things to coordinate, but we can't really begin thinking
> about that while trying to play whack-a-mole with the current buggy
> implementation.
> 
> So this commit removes the setup_data setting from x86_load_linux(),
> while leaving intact the infrastructure we'll need in the future to try
> again.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Dov Murik <dovmurik@linux.ibm.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

I understand from other replies that this patch might have some issues,
but I still tested it for SEV measured boot (OVMF AmdSev build).  This
patch fixes the issue and allows booting correctly.

I also verified that the calculated hashes match the ones calculated by
qemu 7.1.0.

So this fixes the previous issues:
* qemu 7.2.0 produces wrong kernel hash.
* qemu master (commit 6661b8c7fe) produces wrong cmdline hash.

-Dov


> ---
>  hw/i386/microvm.c |  15 ++----
>  hw/i386/x86.c     | 120 +++++-----------------------------------------
>  2 files changed, 17 insertions(+), 118 deletions(-)
> 
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 29f30dd6d3..170a331e3f 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -378,8 +378,7 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
>      MicrovmMachineState *mms = MICROVM_MACHINE(machine);
>      BusState *bus;
>      BusChild *kid;
> -    char *cmdline, *existing_cmdline;
> -    size_t len;
> +    char *cmdline;
>  
>      /*
>       * Find MMIO transports with attached devices, and add them to the kernel
> @@ -388,8 +387,7 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
>       * Yes, this is a hack, but one that heavily improves the UX without
>       * introducing any significant issues.
>       */
> -    existing_cmdline = fw_cfg_read_bytes_ptr(x86ms->fw_cfg, FW_CFG_CMDLINE_DATA);
> -    cmdline = g_strdup(existing_cmdline);
> +    cmdline = g_strdup(machine->kernel_cmdline);
>      bus = sysbus_get_default();
>      QTAILQ_FOREACH(kid, &bus->children, sibling) {
>          DeviceState *dev = kid->child;
> @@ -413,12 +411,9 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
>          }
>      }
>  
> -    len = strlen(cmdline);
> -    if (len > VIRTIO_CMDLINE_TOTAL_MAX_LEN + strlen(existing_cmdline)) {
> -        fprintf(stderr, "qemu: virtio mmio cmdline too large, skipping\n");
> -    } else {
> -        memcpy(existing_cmdline, cmdline, len + 1);
> -    }
> +    fw_cfg_modify_i32(x86ms->fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(cmdline) + 1);
> +    fw_cfg_modify_string(x86ms->fw_cfg, FW_CFG_CMDLINE_DATA, cmdline);
> +
>      g_free(cmdline);
>  }
>  
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index eaff4227bd..6cfdca9acd 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -50,7 +50,6 @@
>  #include "hw/intc/i8259.h"
>  #include "hw/rtc/mc146818rtc.h"
>  #include "target/i386/sev.h"
> -#include "hw/i386/microvm.h"
>  
>  #include "hw/acpi/cpu_hotplug.h"
>  #include "hw/irq.h"
> @@ -770,30 +769,6 @@ static bool load_elfboot(const char *kernel_filename,
>      return true;
>  }
>  
> -typedef struct SetupDataFixup {
> -    void *pos;
> -    hwaddr orig_val, new_val;
> -    uint32_t addr;
> -} SetupDataFixup;
> -
> -static void fixup_setup_data(void *opaque)
> -{
> -    SetupDataFixup *fixup = opaque;
> -    stq_p(fixup->pos, fixup->new_val);
> -}
> -
> -static void reset_setup_data(void *opaque)
> -{
> -    SetupDataFixup *fixup = opaque;
> -    stq_p(fixup->pos, fixup->orig_val);
> -}
> -
> -static void reset_rng_seed(void *opaque)
> -{
> -    SetupData *setup_data = opaque;
> -    qemu_guest_getrandom_nofail(setup_data->data, le32_to_cpu(setup_data->len));
> -}
> -
>  void x86_load_linux(X86MachineState *x86ms,
>                      FWCfgState *fw_cfg,
>                      int acpi_data_size,
> @@ -803,29 +778,20 @@ void x86_load_linux(X86MachineState *x86ms,
>      bool linuxboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
>      uint16_t protocol;
>      int setup_size, kernel_size, cmdline_size;
> -    int dtb_size, setup_data_offset;
>      uint32_t initrd_max;
>      uint8_t header[8192], *setup, *kernel;
> -    hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr = 0, first_setup_data = 0;
> +    hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr = 0;
>      FILE *f;
>      char *vmode;
>      MachineState *machine = MACHINE(x86ms);
> -    SetupData *setup_data;
>      const char *kernel_filename = machine->kernel_filename;
>      const char *initrd_filename = machine->initrd_filename;
> -    const char *dtb_filename = machine->dtb;
> -    char *kernel_cmdline;
> +    const char *kernel_cmdline = machine->kernel_cmdline;
>      SevKernelLoaderContext sev_load_ctx = {};
>      enum { RNG_SEED_LENGTH = 32 };
>  
> -    /*
> -     * Add the NUL terminator, some padding for the microvm cmdline fiddling
> -     * hack, and then align to 16 bytes as a paranoia measure
> -     */
> -    cmdline_size = (strlen(machine->kernel_cmdline) + 1 +
> -                    VIRTIO_CMDLINE_TOTAL_MAX_LEN + 16) & ~15;
> -    /* Make a copy, since we might append arbitrary bytes to it later. */
> -    kernel_cmdline = g_strndup(machine->kernel_cmdline, cmdline_size);
> +    /* Align to 16 bytes as a paranoia measure */
> +    cmdline_size = (strlen(kernel_cmdline) + 16) & ~15;
>  
>      /* load the kernel header */
>      f = fopen(kernel_filename, "rb");
> @@ -966,6 +932,12 @@ void x86_load_linux(X86MachineState *x86ms,
>          initrd_max = x86ms->below_4g_mem_size - acpi_data_size - 1;
>      }
>  
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(kernel_cmdline) + 1);
> +    fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
> +    sev_load_ctx.cmdline_data = (char *)kernel_cmdline;
> +    sev_load_ctx.cmdline_size = strlen(kernel_cmdline) + 1;
> +
>      if (protocol >= 0x202) {
>          stl_p(header + 0x228, cmdline_addr);
>      } else {
> @@ -1078,81 +1050,13 @@ void x86_load_linux(X86MachineState *x86ms,
>      }
>      fclose(f);
>  
> -    /* append dtb to kernel */
> -    if (dtb_filename) {
> -        if (protocol < 0x209) {
> -            fprintf(stderr, "qemu: Linux kernel too old to load a dtb\n");
> -            exit(1);
> -        }
> -
> -        dtb_size = get_image_size(dtb_filename);
> -        if (dtb_size <= 0) {
> -            fprintf(stderr, "qemu: error reading dtb %s: %s\n",
> -                    dtb_filename, strerror(errno));
> -            exit(1);
> -        }
> -
> -        setup_data_offset = cmdline_size;
> -        cmdline_size += sizeof(SetupData) + dtb_size;
> -        kernel_cmdline = g_realloc(kernel_cmdline, cmdline_size);
> -        setup_data = (void *)kernel_cmdline + setup_data_offset;
> -        setup_data->next = cpu_to_le64(first_setup_data);
> -        first_setup_data = cmdline_addr + setup_data_offset;
> -        setup_data->type = cpu_to_le32(SETUP_DTB);
> -        setup_data->len = cpu_to_le32(dtb_size);
> -        load_image_size(dtb_filename, setup_data->data, dtb_size);
> -    }
> -
> -    if (!legacy_no_rng_seed && protocol >= 0x209) {
> -        setup_data_offset = cmdline_size;
> -        cmdline_size += sizeof(SetupData) + RNG_SEED_LENGTH;
> -        kernel_cmdline = g_realloc(kernel_cmdline, cmdline_size);
> -        setup_data = (void *)kernel_cmdline + setup_data_offset;
> -        setup_data->next = cpu_to_le64(first_setup_data);
> -        first_setup_data = cmdline_addr + setup_data_offset;
> -        setup_data->type = cpu_to_le32(SETUP_RNG_SEED);
> -        setup_data->len = cpu_to_le32(RNG_SEED_LENGTH);
> -        qemu_guest_getrandom_nofail(setup_data->data, RNG_SEED_LENGTH);
> -        qemu_register_reset_nosnapshotload(reset_rng_seed, setup_data);
> -        fw_cfg_add_bytes_callback(fw_cfg, FW_CFG_KERNEL_DATA, reset_rng_seed, NULL,
> -                                  setup_data, kernel, kernel_size, true);
> -    } else {
> -        fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, kernel, kernel_size);
> -    }
> -
> -    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
> -    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, cmdline_size);
> -    fw_cfg_add_bytes(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline, cmdline_size);
> -    sev_load_ctx.cmdline_data = (char *)kernel_cmdline;
> -    sev_load_ctx.cmdline_size = cmdline_size;
> -
> +    fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, kernel, kernel_size);
>      fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, prot_addr);
>      fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
>      sev_load_ctx.kernel_data = (char *)kernel;
>      sev_load_ctx.kernel_size = kernel_size;
>  
> -    /*
> -     * If we're starting an encrypted VM, it will be OVMF based, which uses the
> -     * efi stub for booting and doesn't require any values to be placed in the
> -     * kernel header.  We therefore don't update the header so the hash of the
> -     * kernel on the other side of the fw_cfg interface matches the hash of the
> -     * file the user passed in.
> -     */
> -    if (!sev_enabled() && first_setup_data) {
> -        SetupDataFixup *fixup = g_malloc(sizeof(*fixup));
> -
> -        memcpy(setup, header, MIN(sizeof(header), setup_size));
> -        /* Offset 0x250 is a pointer to the first setup_data link. */
> -        fixup->pos = setup + 0x250;
> -        fixup->orig_val = ldq_p(fixup->pos);
> -        fixup->new_val = first_setup_data;
> -        fixup->addr = cpu_to_le32(real_addr);
> -        fw_cfg_add_bytes_callback(fw_cfg, FW_CFG_SETUP_ADDR, fixup_setup_data, NULL,
> -                                  fixup, &fixup->addr, sizeof(fixup->addr), true);
> -        qemu_register_reset(reset_setup_data, fixup);
> -    } else {
> -        fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_ADDR, real_addr);
> -    }
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_ADDR, real_addr);
>      fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, setup_size);
>      fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA, setup, setup_size);
>      sev_load_ctx.setup_data = (char *)setup;
