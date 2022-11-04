Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310C361955D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiKDLbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKDLbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CB6E7B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 04:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667561413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=X2vF9wu9D9A9HBRSXFDC1P9Ez4nhQcXyZNLm0dcpRMo=;
        b=fqRR84iF9Q3l0OtJjtpG7xVA9qWoBN0X6J//KPb6V7Kyo+TuU0sWg+rv7396QyfhcgU5OU
        MnlaBHF3HFb5ZDowOQNAwOfAH22WuSW+lebC25MlK2SfQcVfsoyw66rULqlcV4UpNMIiXD
        kxoxsKEyPrmW4tg14BAsTQ34t7D1QVQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-522-Hu_fJAhWNXizIJW5xlBS0w-1; Fri, 04 Nov 2022 07:30:11 -0400
X-MC-Unique: Hu_fJAhWNXizIJW5xlBS0w-1
Received: by mail-pl1-f198.google.com with SMTP id s15-20020a170902ea0f00b00187050232fcso3401003plg.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 04:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2vF9wu9D9A9HBRSXFDC1P9Ez4nhQcXyZNLm0dcpRMo=;
        b=x2C93vE0+Jks56dTIexE5zuSDtQFalOq48EaHmn6ayxFnJs9bWDtIAUseyy0K+hJCI
         DWdAcyyY/G923Bg3XmyFUgGouC5jw4gayKNaUpRW06N3fqvLPkZVnpCEBqKGYAYgKIkE
         XnUns8weLbRn2sPsCLO8N9eaqL2g3YtBAxMe8DmbvjWZ4VJZx16JOl/LKShoI903Qnoz
         6ms6qXY36d53vKnKFOu2nlRg8hQ/fKkZtCGIX9TZC5guvEGqNJRHcJcUbc7rnuabpntm
         hqVb4zVtkiOKzNycsqu1SxByq1XnM/4XXluJIG2PF9cjsmuYyQl8yE5NZKHmuc2JnH5A
         ++mw==
X-Gm-Message-State: ACrzQf1Lk+gXQrkgKUM8zMtqIl6/7UKCtTJiWdoKD0SPOoynOsaf0tMZ
        Ezqx0DgM79m6mE4lwsifWEm3hVNyHiCmtxl0ovSpB8/iwfYZEN0JAHpbFA3h4caQVzoB0TiS2u8
        I53tDW4tVkgL38UBQSQrzwcDW
X-Received: by 2002:a05:6a00:84b:b0:56d:3cf5:1031 with SMTP id q11-20020a056a00084b00b0056d3cf51031mr30151533pfk.75.1667561410122;
        Fri, 04 Nov 2022 04:30:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6ZmqK77wd2hCvap39otYWhRGk7HSG6DR3nAEU2Jv3tyaB6tseG9Ymp8fTHcgu2gG1DjEWLsQ==
X-Received: by 2002:a05:6a00:84b:b0:56d:3cf5:1031 with SMTP id q11-20020a056a00084b00b0056d3cf51031mr30151497pfk.75.1667561409825;
        Fri, 04 Nov 2022 04:30:09 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p189-20020a625bc6000000b0056abff42a8bsm2503420pfb.69.2022.11.04.04.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:30:08 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Milan Broz <gmazyland@gmail.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Jan Pazdziora <jpazdziora@redhat.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 0/5] Support kdump with LUKS encryption by reusing LUKS volume key
Date:   Fri,  4 Nov 2022 19:29:55 +0800
Message-Id: <20221104113000.487098-1-coxu@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFC v2
 - libcryptsetup interacts with the kernel via sysfs instead of "hacking"
   dm-crypt 
   - to save a kdump copy of the LUKS volume key in 1st kernel
   - to add a logon key using the copy for libcryptsetup in kdump kernel [Milan]
   - to avoid the incorrect usage of LUKS master key in dm-crypt [Milan]
 - save the kdump copy of LUKS volume key randomly [Jan]
 - mark the kdump copy inaccessible [Pingfan]
 - Miscellaneous
   - explain when operations related to the LUKS volume key happen [Jan]
   - s/master key/volume key/g
   - use crash_ instead of kexec_ as function prefix
   - fix commit subject prefixes e.g. "x86, kdump" to x86/crash

With kdump enabled, when the 1st kernel crashes, the system could boot
into the kdump/crash kernel and dump the memory image i.e. /proc/vmcore
to a specified target. Currently, when dumping vmcore to a LUKS
encrypted device, there are two problems,

 - for some machines, a system administrator may not have a chance to
   enter the password to decrypt the device in kdump initramfs after the
   1st kernel crashes 

 - LUKS2 by default use the memory-hard Argon2 key derivation function
   which is quite memory-consuming compared to the limited memory reserved
   for kdump. Take Fedora example, by default, only 256M is reserved for
   systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
   to be reserved for kdump. Note if the memory reserved for kdump can't
   be used by 1st kernel i.e. an user sees ~1300M memory missing in the
   1st kernel. 
 
Besides users (at least for Fedora) usually expect kdump to work out of
the box i.e. no manual password input is needed. And it doesn't make
sense to derivate the key again in kdump kernel which seems to be
redundant work.

Based on Milan's feedback [1] on Kairui's ideas to support kdump with
LUKS encryption, this patch set addresses the above issues by reusing
the LUKS volume key in kdump kernel and here is the life cycle of this
kdump copy of LUKS volume key,

 1. After the 1st kernel loads the initramfs during boot, systemd
    asks for a passphrase from the user and uses it to de-crypt the LUKS
    volume key

 2. After the 1st kernel saving the volume key as a logon key,
    libcrytpsetup notifies the kernel to read this logon key and store a
    temporary copy by writing the key description to
    /sys/kernel/crash_luks_volume_key

 3. After switching to the real root fs, kdump.serivce is started and it 
    loads the kdump kernel using the kexec_file_load syscall

 4. The kexec_file_load syscall saves the temporary copy of the volume
    key to kdump reserved memory and wipe the copy.

 5. When the 1st kernel crashes and kdump kernel is booted,
    libcryptsetup asks the kdump kernel to add a logon key using
    the volume key stored in kdump reserved memory by writing the key
    description to /sys/kernel/crash_luks_volume_key

 6. The system gets rebooted to the 1st kernel after dumping vmcore to
    the LUKS encrypted device is finished

Note the kdump copy of LUKS volume key never leaves the kernel space and
is saved in the memory area exclusively reserved for kdump where even
the 1st kernel has no direct access. 

Milan's major concern [2] on previous version is "storing the encryption
key to yet another place are creating another attack vector". To further
secure this copy, two additional protections are added,
 - save the copy randomly in kdump reserved memory as suggested by Jan
 - clear the _PAGE_PRESENT flag of the page that stores the copy as
   suggested by Pingfan

If there is no further security concern with this approach or any other
concern, I will drop the following assumptions,
  - only x86 is supported
  - there is only one LUKS device for the system

to extend the support to other architectures including POWER, ARM and
s390x and address the case of multiple LUKS devices. Any feedback will be 
appreciated, thanks!

For a proof of concept, I've patched cryptsetup [3] in a quick-and-dirty
way to support a new option "--kdump-kernel-master-key"
and hacked systemd [4]. It works for Fedora 35.

[1] https://yhbt.net/lore/all/e5abd089-3398-fdb4-7991-0019be434b79@gmail.com/
[2] https://lwn.net/ml/linux-kernel/c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com/
[3] https://gitlab.com/coxu/cryptsetup/-/commit/750a46d933fac82e0c994b5c41de40a0b8cac647
[4] https://github.com/coiby/systemd/tree/reuse_kdump_master_key

Coiby Xu (5):
  kexec_file: allow to place kexec_buf randomly
  crash_dump: save the LUKS volume key temporarily
  x86/crash: pass the LUKS volume key to kdump kernel
  x86/crash: make the page that stores the LUKS volume key inaccessible
  crash_dump: retrieve LUKS volume key in kdump kernel

 arch/x86/include/asm/crash.h       |   1 +
 arch/x86/kernel/crash.c            |  47 ++++++-
 arch/x86/kernel/kexec-bzimage64.c  |   7 +
 arch/x86/kernel/machine_kexec_64.c |  16 +++
 include/linux/crash_core.h         |   2 +
 include/linux/crash_dump.h         |   2 +
 include/linux/kexec.h              |   6 +
 kernel/crash_dump.c                | 200 +++++++++++++++++++++++++++++
 kernel/kexec_file.c                |  15 +++
 kernel/ksysfs.c                    |  19 +++
 10 files changed, 314 insertions(+), 1 deletion(-)

-- 
2.37.3

