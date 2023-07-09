Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FA974C861
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 23:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjGIVTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 17:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjGIVSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 17:18:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7262CE7E
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 14:18:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99384a80af7so434800366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 14:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688937497; x=1691529497;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fi6td3Y7wMFuyRlsn4k4E25PduW3/vFxmfNk0aaRgrc=;
        b=DOF3zWCZt+vN2QVy8G3G7uB1+LXIZG4fWQDoFImfwUJWWgE2vInaZXY8fzNNsrXChf
         P1joWD/QVtoVRCI797Tw+o7HDyQpUTeGjHVlgPT0ieurkqhA86wVRuWine72Nhh52Yr9
         FsfrYpdCkBBkFvsLLfiYXpQi+FghuJh5rm4Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688937497; x=1691529497;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fi6td3Y7wMFuyRlsn4k4E25PduW3/vFxmfNk0aaRgrc=;
        b=LAV00pWnD17WW9Wv/w45waACCmUM+P7djhiEjQGLA7r8OvL5ta7DsLO2XdhSvF3be3
         zBJ8MTT++hXuwsnTt8dEpCs/CclWnJTecaThiSqTSDwYJiupFhfwYxyWd1nqEjCmolmO
         VVvI7pkrDqS80GE1iinjcEO7Bsp8dFn/jzszfrAEeW6ooN6+Qg1HLGsZ+SKNuPMzejdl
         jnHWA+X2cFtK9UotF9NLwBGO1UzL6jB5M/unr0zqI89Uydmws9jAbqlfpo6CSK05qBIO
         tSD0+rKW+7AViPGo6e48qFjtCha9r9hJ4e4eYGHKLEu0yt2e/aQhbCBVAz2T8BDafRre
         31WQ==
X-Gm-Message-State: ABy/qLYHpJHZrnLb0J48fTyqCJnLrWqfQd73kUzksCCLDSayBFkza0a0
        D5O+EYjX/P9WWqSMuAoqBxTo7fjsBCVcwtjXTm6r9nPF
X-Google-Smtp-Source: APBJJlEPWG9zIJkPnFq3Y9VRECsEOe9XyzL3fYVHwD7xoatIzEBnwvtfcCqWtKnQXbDDOowfvbMVLg==
X-Received: by 2002:a17:906:a085:b0:992:6d73:568e with SMTP id q5-20020a170906a08500b009926d73568emr8444882ejy.68.1688937497175;
        Sun, 09 Jul 2023 14:18:17 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm5165218ejb.213.2023.07.09.14.18.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 14:18:16 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51e35791a83so3866467a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 14:18:16 -0700 (PDT)
X-Received: by 2002:aa7:c0d9:0:b0:51e:126a:403a with SMTP id
 j25-20020aa7c0d9000000b0051e126a403amr8509100edp.13.1688937496282; Sun, 09
 Jul 2023 14:18:16 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Jul 2023 14:17:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8sPDVoWgaceAs1AiwZrHV8mtC3vQNGbeV6-RypJi6aw@mail.gmail.com>
Message-ID: <CAHk-=wj8sPDVoWgaceAs1AiwZrHV8mtC3vQNGbeV6-RypJi6aw@mail.gmail.com>
Subject: Linux 6.5-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right on schedule two weeks after the 6.4 release, here we are and the
merge window is closed.

Nothing hugely unusual stands out - we had some VM annoyance, but the
fixes for that don't even show in the diffstat, which is (as usual)
dominated by drivers, with tooling and architecture updates a distant
second and third.

And even if you filter out all the drivers, tooling and architecture
changes out, the diff is still dominated by header file updates (much
of it due to some re-organization around our atomic ops) and
documentation updates.

At only after you filter out _that_ do you start seeing the core
changes - various filesystem updates (btrfs, ovlfs, f2fs, ext4), core
networking code, and then core kernel and mm updates.

Anyway, none of it looks hugely unusual. The biggest single mention
probably goes to what wasn't merged, with the bcachefs pull request
resulting in a long thread (we didn't hit a hundred emails yet, but
it's not far away).

Let's calm this party down. I have this slight suspicion that this may
be one of those releases that may drag out, not because there are any
particular issues I expect problems with, but simply due to lot of
Europe going on vacation for the month of August. But who knows...
We'll see how things develop.

And below is obviously just the usual shortlog of my merges, since at
around 12k non-merge commits, the full shortlog is much too big (even
if this was a fairly small merge window).

                  Linus

---

Adrian Glaubitz (1):
    sh updates

Alex Williamson (1):
    VFIO updates

Alexander Gordeev (3):
    s390 updates (x2)
    more s390 updates

Alexandre Belloni (2):
    i3c updates
    RTC updates

Amir Goldstein (2):
    overlayfs update
    more overlayfs updates

Andreas Gruenbacher (1):
    gfs2 updates

Andrew Morton (3):
    mm updates
    non-mm updates
    hotfixes

Ard Biesheuvel (1):
    EFI updates

Arnd Bergmann (7):
    ARM SoC devicetree updates
    new ARM SoC support
    ARM SoC driver updates
    ARM SoC defconfig updates
    ARM SoC updates
    SoC fixes
    asm-generic updates

Bartosz Golaszewski (1):
    gpio updates

Bjorn Andersson (2):
    hwspinlock update
    remoteproc updates

Bjorn Helgaas (1):
    pci updates

Borislav Petkov (14):
    EDAC updates
    RAS updates
    x86 instruction alternatives updates
    x86 build update
    x86 resource control updates
    x86 confidential computing update
    x86 cpu updates
    x86 microcode loader updates
    misc x86 updates
    x86 mtrr updates
    x86 SEV updates
    SGX update
    x86 fpu fix
    irq update

Casey Schaufler (1):
    smack updates

Catalin Marinas (2):
    arm64 updates
    arm64 fix

Christian Brauner (7):
    ntfs updates
    misc vfs updates
    vfs rename locking updates
    vfs file handling updates
    vfs mount updates
    vfs fix
    vfs fixes

Christoph Hellwig (2):
    dma-mapping updates
    dma-mapping fixes

Chuck Lever (2):
    nfsd updates
    nfsd fix

Damien Le Moal (2):
    zonefs updates
    ata updates

Dan Williams (1):
    CXL updates

Daniel Thompson (1):
    kgdb updates

Darrick Wong (4):
    xfs updates
    iomap updates
    more xfs updates
    xfs fix

Dave Airlie (2):
    drm updates
    drm fixes

Dave Hansen (4):
    x86 irq updates
    x86 platform updates
    x86 tdx updates
    x86 cleanups

David Kleikamp (1):
    jfs updates

David Sterba (1):
    btrfs updates

David Teigland (1):
    dlm updates

David Woodhouse (1):
    mm fix

Dinh Nguyen (1):
    nios2 updates

Dmitry Torokhov (1):
    input updates

Eric Biggers (2):
    fscrypt update
    fsverity updates

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (5):
    Char/Misc updates
    driver core updates
    staging driver updates
    tty/serial driver updates
    USB / Thunderbolt driver updates

Guenter Roeck (1):
    hwmon updates

Guo Ren (1):
    arch/csky update

Gustavo Silva (1):
    flexible-array update

Hans de Goede (1):
    x86 platform driver updates

Helge Deller (3):
    fbdev updates
    parisc updates
    more parisc architecture updates

Herbert Xu (1):
    crypto updates

Huacai Chen (1):
    LoongArch updates

Ilya Dryomov (1):
    ceph updates

Ingo Molar (1):
    objtool updates

Ingo Molnar (4):
    scheduler updates
    locking updates
    perf events updates
    x86 mm updates

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (2):
    networking changes
    networking fixes

James Bottomley (2):
    SCSI updates
    more SCSI updates

Jan Kara (3):
    fsnotify updates
    misc filesystem updates
    fsnotify fix

Jason Gunthorpe (2):
    iommufd updates
    rdma updates

Jassi Brar (1):
    mailbox updates

Jens Axboe (5):
    splice updates
    io_uring updates
    block updates
    io_uring fixes
    more block updates

Jiri Kosina (1):
    HID updates

Joerg Roedel (1):
    iommu updates

John Johansen (1):
    apparmor updates

Jon Mason (1):
    NTB updates

Jonathan Corbet (4):
    documentation updates
    arm documentation move
    arm64 documentation move
    mode documentation updates

Juergen Gross (1):
    xen updates

Kees Cook (4):
    execve updates
    pstore updates
    hardening updates
    hardening fixes

Konstantin Komarov (1):
    ntfs3 updates

Lee Jones (3):
    MFD updates
    LED updates
    backlight updates

Linus Walleij (1):
    pin control updates

Luis Chamberlain (4):
    module updates
    sysctl updates
    sysctl fix
    another sysctl fix

Mark Brown (5):
    regmap updates
    regulator updates
    spi updates
    regulator fix
    spi fixes

Masahiro Yamada (1):
    Kbuild updates

Masami Hiramatsu (1):
    probes updates

Mauro Carvalho Chehab (1):
    media updates

Max Filippov (1):
    xtensa updates

Michael Ellerman (2):
    powerpc updates
    powerpc fixes

Michael Tsirkin (1):
    virtio updates

Micka=C3=ABl Sala=C3=BCn (1):
    landlock updates

Miguel Ojeda (2):
    rust updates
    auxdisplay update

Mike Rapoport (1):
    memblock updates

Mike Snitzer (1):
    device mapper updates

Mimi Zohar (1):
    integrity subsystem updates

Namhyung Kim (2):
    perf tools updates
    more perf tools updates

Palmer Dabbelt (2):
    RISC-V updates
    more RISC-V updates

Paolo Bonzini (1):
    kvm updates

Paul McKenney (2):
    RCU updates
    nolibc updates

Paul Moore (3):
    audit update
    selinux updates
    lsm updates

Peter Zijlstra (1):
    scope-based resource management infrastructure

Petr Mladek (1):
    livepatching update

Rafael Wysocki (6):
    ACPI updates
    power management updates
    thermal control updates
    ACPI fix
    more power management updates
    more ACPI updates

Rob Herring (2):
    devicetree updates
    more devicetree updates

Russell King (1):
    ARM updates

Sebastian Reichel (2):
    power supply and reset updates
    HSI updates

Shuah Khan (2):
    KUnit updates
    kselftest updates

Stephen Boyd (2):
    clk updates
    more clk updates

Steve French (3):
    ksmbd server updates
    smb client updates
    more smb client updates

Steven Rostedt (4):
    tracing fix
    tracing updates
    tracing tooling updates
    tracing fixes

Takashi Iwai (2):
    sound updates
    sound fixes

Takashi Sakamoto (1):
    firewire updates

Ted Ts'o (1):
    ext4 updates

Tejun Heo (3):
    workqueue updates
    ordered workqueue creation updates
    cgroup updates

Thierry Reding (1):
    pwm updates

Thomas Bogendoerfer (2):
    MIPS updates
    MIPS fixes

Thomas Gleixner (8):
    debugobjects update
    irq updates
    x86 boot updates
    SMP updates
    timer updates
    x86 core updates
    x86 fix (x2)

Trond Myklebust (1):
    NFS client updates

Tzung-Bi Shih (1):
    chrome platform updates

Ulf Hansson (2):
    MMC updates
    mmc fix

Vinod Koul (3):
    soundwire updates
    phy updates
    dmaengine updates

Vishal Verma (1):
    nvdimm and DAX updates

Vlastimil Babka (1):
    slab updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (2):
    i2c updates
    more i2c updates

Yury Norov (1):
    bitmap updates
