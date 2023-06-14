Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9AF729441
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240840AbjFIJGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240803AbjFIJFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:05:23 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B24B2D4A;
        Fri,  9 Jun 2023 02:05:21 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.5.185])
        by gateway (Coremail) with SMTP id _____8Cx+elP64JkifsAAA--.2980S3;
        Fri, 09 Jun 2023 17:05:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxluRO64JkSXEKAA--.31854S2;
        Fri, 09 Jun 2023 17:05:18 +0800 (CST)
From:   Tianrui Zhao <zhaotianrui@loongson.cn>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn,
        Xi Ruoyao <xry111@xry111.site>, zhaotianrui@loongson.cn,
        tangyouling@loongson.cn
Subject: [PATCH v13 00/30] Add KVM LoongArch support
Date:   Fri,  9 Jun 2023 17:04:48 +0800
Message-Id: <20230609090518.2130926-1-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxluRO64JkSXEKAA--.31854S2
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds KVM LoongArch support. Loongson 3A5000 supports hardware
assisted virtualization. With cpu virtualization, there are separate
hw-supported user mode and kernel mode in guest mode. With memory
virtualization, there are two-level hw mmu table for guest mode and host
mode. Also there is separate hw cpu timer with consant frequency in
guest mode, so that vm can migrate between hosts with different freq.
Currently, we are able to boot LoongArch Linux Guests.

Few key aspects of KVM LoongArch added by this series are:
1. Enable kvm hardware function when kvm module is loaded.
2. Implement VM and vcpu related ioctl interface such as vcpu create,
   vcpu run etc. GET_ONE_REG/SET_ONE_REG ioctl commands are use to
   get general registers one by one.
3. Hardware access about MMU, timer and csr are emulated in kernel.
4. Hardwares such as mmio and iocsr device are emulated in user space
   such as APIC, IPI, pci devices etc.

The running environment of LoongArch virt machine:
1. Cross tools to build kernel and uefi:
   $ wget https://github.com/loongson/build-tools/releases/download/2022.09.06/loongarch64-clfs-6.3-cross-tools-gcc-glibc.tar.xz
   tar -vxf loongarch64-clfs-6.3-cross-tools-gcc-glibc.tar.xz  -C /opt
   export PATH=/opt/cross-tools/bin:$PATH
   export LD_LIBRARY_PATH=/opt/cross-tools/lib:$LD_LIBRARY_PATH
   export LD_LIBRARY_PATH=/opt/cross-tools/loongarch64-unknown-linux-gnu/lib/:$LD_LIBRARY_PATH
2. This series is based on the linux source code:
   https://github.com/loongson/linux-loongarch-kvm
   Build command:
   git checkout kvm-loongarch
   make ARCH=loongarch CROSS_COMPILE=loongarch64-unknown-linux-gnu- loongson3_defconfig
   make ARCH=loongarch CROSS_COMPILE=loongarch64-unknown-linux-gnu-
3. QEMU hypervisor with LoongArch supported:
   https://github.com/loongson/qemu
   Build command:
   git checkout kvm-loongarch
   ./configure --target-list="loongarch64-softmmu"  --enable-kvm
   make
4. Uefi bios of LoongArch virt machine:
   Link: https://github.com/tianocore/edk2-platforms/tree/master/Platform/Loongson/LoongArchQemuPkg#readme
5. you can also access the binary files we have already build:
   https://github.com/yangxiaojuan-loongson/qemu-binary
The command to boot loongarch virt machine:
   $ qemu-system-loongarch64 -machine virt -m 4G -cpu la464 \
   -smp 1 -bios QEMU_EFI.fd -kernel vmlinuz.efi -initrd ramdisk \
   -serial stdio   -monitor telnet:localhost:4495,server,nowait \
   -append "root=/dev/ram rdinit=/sbin/init console=ttyS0,115200" \
   --nographic

Changes for v13:
1. Remove patch-28 "Implement probe virtualization when cpu init", as the
virtualization information about FPU,PMP,LSX in guest.options,options_dyn
is not used and the gcfg reg value can be read in kvm_hardware_enable, so
remove the previous cpu_probe_lvz function.
2. Fix vcpu_enable_cap interface, it should return -EINVAL directly, as
FPU cap is enable by default, and do not support any other caps now.
3. Simplify the jirl instruction with jr when without return addr,
simplify case HW0 ... HW7 statment in interrupt.c
4. Rename host_stack,host_gp in kvm_vcpu_arch to host_sp,host_tp.
5. Remove 'cpu' parameter in _kvm_check_requests, as 'cpu' is not used,
and remove 'cpu' parameter in kvm_check_vmid function, as it can get
cpu number by itself.

Changes for v12:
1. Improve the gcsr write/read/xchg interface to avoid the previous
instruction statment like parse_r and make the code easy understanding,
they are implemented in asm/insn-def.h and the instructions consistent
of "opcode" "rj" "rd" "simm14" arguments.
2. Fix the maintainers list of LoongArch KVM.

Changes for v11:
1. Add maintainers for LoongArch KVM.

Changes for v10:
1. Fix grammatical problems in LoongArch documentation.
2. It is not necessary to save or restore the LOONGARCH_CSR_PGD when
vcpu put and vcpu load, so we remove it.

Changes for v9:
1. Apply the new defined interrupt number macros in loongarch.h to kvm,
such as INT_SWI0, INT_HWI0, INT_TI, INT_IPI, etc. And remove the
previous unused macros.
2. Remove unused variables in kvm_vcpu_arch, and reorder the variables
to make them more standard.

Changes for v8:
1. Adjust the cpu_data.guest.options structure, add the ases flag into
it, and remove the previous guest.ases. We do this to keep consistent
with host cpu_data.options structure.
2. Remove the "#include <asm/kvm_host.h>" in some files which also
include the "<linux/kvm_host.h>". As linux/kvm_host.h already include
the asm/kvm_host.h.
3. Fix some unstandard spelling and grammar errors in comments, and
improve a little code format to make it easier and standard.

Changes for v7:
1. Fix the kvm_save/restore_hw_gcsr compiling warnings reported by
kernel test robot. The report link is:
https://lore.kernel.org/oe-kbuild-all/202304131526.iXfLaVZc-lkp@intel.com/
2. Fix loongarch kvm trace related compiling problems.

Changes for v6:
1. Fix the Documentation/virt/kvm/api.rst compile warning about
loongarch parts.

Changes for v5:
1. Implement get/set mp_state ioctl interface, and only the
KVM_MP_STATE_RUNNABLE state is supported now, and other states
will be completed in the future. The state is also used when vcpu
run idle instruction, if vcpu state is changed to RUNNABLE, the
vcpu will have the possibility to be woken up.
2. Supplement kvm document about loongarch-specific part, such as add
api introduction for GET/SET_ONE_REG, GET/SET_FPU, GET/SET_MP_STATE,
etc.
3. Improve the kvm_switch_to_guest function in switch.S, remove the
previous tmp,tmp1 arguments and replace it with t0,t1 reg.

Changes for v4:
1. Add a csr_need_update flag in _vcpu_put, as most csr registers keep
unchanged during process context switch, so we need not to update it
every time. We can do this only if the soft csr is different form hardware.
That is to say all of csrs should update after vcpu enter guest, as for
set_csr_ioctl, we have written soft csr to keep consistent with hardware.
2. Improve get/set_csr_ioctl interface, we set SW or HW or INVALID flag
for all csrs according to it's features when kvm init. In get/set_csr_ioctl,
if csr is HW, we use gcsrrd/ gcsrwr instruction to access it, else if csr is
SW, we use software to emulate it, and others return false.
3. Add set_hw_gcsr function in csr_ops.S, and it is used in set_csr_ioctl.
We have splited hw gcsr into three parts, so we can calculate the code offset
by gcsrid and jump here to run the gcsrwr instruction. We use this function to
make the code easier and avoid to use the previous SET_HW_GCSR(XXX) interface.
4. Improve kvm mmu functions, such as flush page table and make clean page table
interface.

Changes for v3:
1. Remove the vpid array list in kvm_vcpu_arch and use a vpid variable here,
because a vpid will never be recycled if a vCPU migrates from physical CPU A
to B and back to A.
2. Make some constant variables in kvm_context to global such as vpid_mask,
guest_eentry, enter_guest, etc.
3. Add some new tracepoints, such as kvm_trace_idle, kvm_trace_cache,
kvm_trace_gspr, etc.
4. There are some duplicate codes in kvm_handle_exit and kvm_vcpu_run,
so we move it to a new function kvm_pre_enter_guest.
5. Change the RESUME_HOST, RESUME_GUEST value, return 1 for resume guest
and "<= 0" for resume host.
6. Fcsr and fpu registers are saved/restored together.

Changes for v2:
1. Seprate the original patch-01 and patch-03 into small patches, and the
patches mainly contain kvm module init, module exit, vcpu create, vcpu run,
etc.
2. Remove the original KVM_{GET,SET}_CSRS ioctl in the kvm uapi header,
and we use the common KVM_{GET,SET}_ONE_REG to access register.
3. Use BIT(x) to replace the "1 << n_bits" statement.

Tianrui Zhao (30):
  LoongArch: KVM: Add kvm related header files
  LoongArch: KVM: Implement kvm module related interface
  LoongArch: KVM: Implement kvm hardware enable, disable interface
  LoongArch: KVM: Implement VM related functions
  LoongArch: KVM: Add vcpu related header files
  LoongArch: KVM: Implement vcpu create and destroy interface
  LoongArch: KVM: Implement vcpu run interface
  LoongArch: KVM: Implement vcpu handle exit interface
  LoongArch: KVM: Implement vcpu get, vcpu set registers
  LoongArch: KVM: Implement vcpu ENABLE_CAP ioctl interface
  LoongArch: KVM: Implement fpu related operations for vcpu
  LoongArch: KVM: Implement vcpu interrupt operations
  LoongArch: KVM: Implement misc vcpu related interfaces
  LoongArch: KVM: Implement vcpu load and vcpu put operations
  LoongArch: KVM: Implement vcpu status description
  LoongArch: KVM: Implement update VM id function
  LoongArch: KVM: Implement virtual machine tlb operations
  LoongArch: KVM: Implement vcpu timer operations
  LoongArch: KVM: Implement kvm mmu operations
  LoongArch: KVM: Implement handle csr excption
  LoongArch: KVM: Implement handle iocsr exception
  LoongArch: KVM: Implement handle idle exception
  LoongArch: KVM: Implement handle gspr exception
  LoongArch: KVM: Implement handle mmio exception
  LoongArch: KVM: Implement handle fpu exception
  LoongArch: KVM: Implement kvm exception vector
  LoongArch: KVM: Implement vcpu world switch
  LoongArch: KVM: Enable kvm config and add the makefile
  LoongArch: KVM: Supplement kvm document about LoongArch-specific part
  LoongArch: KVM: Add maintainers for LoongArch KVM

 Documentation/virt/kvm/api.rst             |  71 +-
 MAINTAINERS                                |  12 +
 arch/loongarch/Kbuild                      |   1 +
 arch/loongarch/Kconfig                     |   2 +
 arch/loongarch/configs/loongson3_defconfig |   2 +
 arch/loongarch/include/asm/insn-def.h      |  55 ++
 arch/loongarch/include/asm/inst.h          |  16 +
 arch/loongarch/include/asm/kvm_csr.h       | 231 ++++++
 arch/loongarch/include/asm/kvm_host.h      | 253 ++++++
 arch/loongarch/include/asm/kvm_types.h     |  11 +
 arch/loongarch/include/asm/kvm_vcpu.h      |  97 +++
 arch/loongarch/include/asm/loongarch.h     |  20 +-
 arch/loongarch/include/uapi/asm/kvm.h      | 106 +++
 arch/loongarch/kernel/asm-offsets.c        |  32 +
 arch/loongarch/kvm/Kconfig                 |  38 +
 arch/loongarch/kvm/Makefile                |  22 +
 arch/loongarch/kvm/csr_ops.S               |  76 ++
 arch/loongarch/kvm/exit.c                  | 707 +++++++++++++++++
 arch/loongarch/kvm/interrupt.c             | 113 +++
 arch/loongarch/kvm/main.c                  | 347 ++++++++
 arch/loongarch/kvm/mmu.c                   | 725 +++++++++++++++++
 arch/loongarch/kvm/switch.S                | 301 +++++++
 arch/loongarch/kvm/timer.c                 | 266 +++++++
 arch/loongarch/kvm/tlb.c                   |  32 +
 arch/loongarch/kvm/trace.h                 | 168 ++++
 arch/loongarch/kvm/vcpu.c                  | 869 +++++++++++++++++++++
 arch/loongarch/kvm/vm.c                    |  76 ++
 arch/loongarch/kvm/vmid.c                  |  66 ++
 include/uapi/linux/kvm.h                   |   9 +
 29 files changed, 4710 insertions(+), 14 deletions(-)
 create mode 100644 arch/loongarch/include/asm/insn-def.h
 create mode 100644 arch/loongarch/include/asm/kvm_csr.h
 create mode 100644 arch/loongarch/include/asm/kvm_host.h
 create mode 100644 arch/loongarch/include/asm/kvm_types.h
 create mode 100644 arch/loongarch/include/asm/kvm_vcpu.h
 create mode 100644 arch/loongarch/include/uapi/asm/kvm.h
 create mode 100644 arch/loongarch/kvm/Kconfig
 create mode 100644 arch/loongarch/kvm/Makefile
 create mode 100644 arch/loongarch/kvm/csr_ops.S
 create mode 100644 arch/loongarch/kvm/exit.c
 create mode 100644 arch/loongarch/kvm/interrupt.c
 create mode 100644 arch/loongarch/kvm/main.c
 create mode 100644 arch/loongarch/kvm/mmu.c
 create mode 100644 arch/loongarch/kvm/switch.S
 create mode 100644 arch/loongarch/kvm/timer.c
 create mode 100644 arch/loongarch/kvm/tlb.c
 create mode 100644 arch/loongarch/kvm/trace.h
 create mode 100644 arch/loongarch/kvm/vcpu.c
 create mode 100644 arch/loongarch/kvm/vm.c
 create mode 100644 arch/loongarch/kvm/vmid.c

-- 
2.39.1

