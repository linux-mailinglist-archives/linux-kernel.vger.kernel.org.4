Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6899616357
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiKBNFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiKBNFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:05:13 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F97BCAE;
        Wed,  2 Nov 2022 06:05:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d24so16519968pls.4;
        Wed, 02 Nov 2022 06:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Huyh9wUKlgeHcrDnqlzfeeXrkbo7IuxRYJnuX9s8J4U=;
        b=GmrLDJoVj+xHnDQUa/s1aE0/2/0uPVB41AXo8Yh/AFc3pMPlNQmBwTjJsTbWGxbQ6W
         tUTpqNJ0SSIva40zLzQNRtJeRaYMPOqL2/b8HWD3NXCq+PrhuPWPClYI0OB+HsG+s6tP
         G41wlFYnhO+pye0ONy5uDRt2cV/rDFz9X8Ev63vKPAuwS9qHcnAzbtydtr4B295QgFvY
         DjmROBwhCgmmtSyZF1TwS6tTJWm+/zJ94H1AZiceNE8zDmhGwGz59WErXNsWkMJyPbS/
         2pY3t4FszouIRgcZDqrI0Pjq0bHqr3keHUElPnHulsA0hn+Ax4Ef4Yp8xtNMuMpe2YD2
         Ktuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Huyh9wUKlgeHcrDnqlzfeeXrkbo7IuxRYJnuX9s8J4U=;
        b=RV5vhztsSl+Wn2n5d+zvYiWJjwQSDED3EUPUfYx7lb/bouNMVnz9L2Nix8QlJXty0b
         OOkH3Up7XdsvAvzIlx10UDspdcin7fTibJRTENMsmyoSj/LIMh0moX41XhKco5xuB3+s
         MHgINB0LKSBXUY7QY54NJFC/Ym2zdfdlVjaL0Fjg3fiLB17XKHG4PZgfSqALio8kmon0
         Hzgf3jaFmg2ii21Fr6Ohbfppc1JhAPszOCgV3ZdY2YQEpD4lPao5jJd3qOr6I4cVA/Fr
         T7Zokoadyo309V3b9SelTfkReiJ6xlz5c195+OQZkff48FCms/U9JQEaRhuy+2aZIZcn
         jLQg==
X-Gm-Message-State: ACrzQf0f+lYTTZq/fo5LLFJjP/U5/eLzkci34PnAjzW2NgxdZkur8IQZ
        qyJiGoOQlvu4rnGU8PYkmp0=
X-Google-Smtp-Source: AMsMyM5da1P+z5SC6LESKmsXTekNfxELJMlJkCDcJaieLHd+JXNW11xqXAsm+I1Z/8BFyNvd0nvFTw==
X-Received: by 2002:a17:903:1d0:b0:187:1305:39d5 with SMTP id e16-20020a17090301d000b00187130539d5mr19385133plh.93.1667394311166;
        Wed, 02 Nov 2022 06:05:11 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-50.three.co.id. [116.206.28.50])
        by smtp.gmail.com with ESMTPSA id n4-20020a6546c4000000b0046ec7beb53esm7617767pgr.8.2022.11.02.06.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 06:05:10 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 84D88104209; Wed,  2 Nov 2022 20:05:07 +0700 (WIB)
Date:   Wed, 2 Nov 2022 20:05:07 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 21/21] docs: gunyah: Document Gunyah VM Manager
Message-ID: <Y2JrA2rXJuRrFALF@debian.me>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-22-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hj7LpSjy5/N/rAip"
Content-Disposition: inline
In-Reply-To: <20221026185846.3983888-22-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hj7LpSjy5/N/rAip
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 26, 2022 at 11:58:46AM -0700, Elliot Berman wrote:
> diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/vir=
t/gunyah/vm-manager.rst
> new file mode 100644
> index 000000000000..c232ba05de7e
> --- /dev/null
> +++ b/Documentation/virt/gunyah/vm-manager.rst
> @@ -0,0 +1,94 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Virtual Machine Manager
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Gunyah Virtual Machine Manager is a Linux driver to support launchin=
g virtual machines.
> +
> +Summary
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +Gunyah VMM presently supports launching non-proxy scheduled Linux-like v=
irtual machines.
> +
> +Sample Userspace VMM
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +A sample userspace VMM is included in samples/gunyah/ along with a sampl=
e minimal devicetree
> +that can be used to launch a Linux-like virtual machine under Gunyah. To=
 build this sample, enable
> +CONFIG_SAMPLE_GUNYAH.
> +
> +IOCTLs and userspace VMM flows
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +The kernel exposes a char device interface at /dev/gunyah.
> +
> +To create a VM, use the GH_CREATE_VM ioctl. A successful call will retur=
n a "Gunyah VM" file descriptor.
> +
> +/dev/gunyah API Descriptions
> +----------------------------
> +
> +GH_CREATE_VM
> +~~~~~~~~~~~~
> +
> +Creates a Gunyah VM. The argument is reserved for future use and must be=
 0.
> +
> +Gunyah VM API Descriptions
> +--------------------------
> +
> +GH_VM_SET_USER_MEM_REGION
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +  struct gh_userspace_memory_region {
> +	__u32 label;
> +	__u32 flags;
> +	__u64 guest_phys_addr;
> +	__u64 memory_size;
> +	__u64 userspace_addr;
> +  };
> +
> +This ioctl allows the user to create or delete a memory parcel for a gue=
st
> +virtual machine. Each memory region is uniquely identified by a label;
> +attempting to create two memory regions with the same label is not allow=
ed.
> +
> +While VMM is guest-agnostic and allows runtime addition of memory region=
s,
> +Linux guest virtual machines do not support accepting memory regions at =
runtime.
> +Thus, memory regions should be provided before starting the VM and the VM
> +configured to accept those memory regions at boot-up.
> +
> +The guest physical address is used by Linux to check the requested user =
regions
> +do not overlap and to help find a corresponding memory region for calls =
like
> +GH_VM_SET_DTB_CONFIG.
> +
> +To delete a memory region, call GH_VM_SET_USER_MEM_REGION with label set=
 to the
> +memory region of interest and memory_size set to 0.
> +
> +The flags field of gh_userspace_memory_region can set the following bits=
=2E All
> +other bits must be 0 and are reserved for future use. The ioctl will ret=
urn
> +-EINVAL if an unsupported bit is detected.
> +
> +  - GH_MEM_ALLOW_READ/GH_MEM_ALLOW_WRITE/GH_MEM_ALLOW_EXEC sets read/wri=
te/exec permissions
> +    for the guest, respectively.
> +
> +  - GH_MEM_LENT means that the memory will be unmapped from the host and=
 be unaccessible by
> +    the host while the guest has the region.
> +
> +GH_VM_SET_DTB_CONFIG
> +~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +  struct gh_vm_dtb_config {
> +	__u64 gpa;
> +	__u64 size;
> +  };
> +
> +This ioctl sets the location of the VM's devicetree blob and is used by =
Gunyah
> +Resource Manager to allocate resources.
> +
> +GH_VM_START
> +~~~~~~~~~~~
> +
> +This ioctl starts the virtual machine.

I think the wording can be better:

---- >8 ----

diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/=
gunyah/vm-manager.rst
index c232ba05de7e96..772fd970b91d7e 100644
--- a/Documentation/virt/gunyah/vm-manager.rst
+++ b/Documentation/virt/gunyah/vm-manager.rst
@@ -4,18 +4,15 @@
 Virtual Machine Manager
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-The Gunyah Virtual Machine Manager is a Linux driver to support launching =
virtual machines.
-
-Summary
-=3D=3D=3D=3D=3D=3D=3D
-
-Gunyah VMM presently supports launching non-proxy scheduled Linux-like vir=
tual machines.
+The Gunyah Virtual Machine Manager is a Linux driver for launching virtual
+machines using Gunyah. It presently supports launching non-proxy scheduled
+Linux-like virtual machines.
=20
 Sample Userspace VMM
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-A sample userspace VMM is included in samples/gunyah/ along with a sample =
minimal devicetree
-that can be used to launch a Linux-like virtual machine under Gunyah. To b=
uild this sample, enable
+A sample userspace VMM is included in samples/gunyah/ along with a minimal
+devicetree that can be used to launch a VM. To build this sample, enable
 CONFIG_SAMPLE_GUNYAH.
=20
 IOCTLs and userspace VMM flows
@@ -23,7 +20,8 @@ IOCTLs and userspace VMM flows
=20
 The kernel exposes a char device interface at /dev/gunyah.
=20
-To create a VM, use the GH_CREATE_VM ioctl. A successful call will return =
a "Gunyah VM" file descriptor.
+To create a VM, use the GH_CREATE_VM ioctl. A successful call will return a
+"Gunyah VM" file descriptor.
=20
 /dev/gunyah API Descriptions
 ----------------------------
@@ -51,29 +49,28 @@ GH_VM_SET_USER_MEM_REGION
=20
 This ioctl allows the user to create or delete a memory parcel for a guest
 virtual machine. Each memory region is uniquely identified by a label;
-attempting to create two memory regions with the same label is not allowed.
+attempting to create two regions with the same label is not allowed.
=20
 While VMM is guest-agnostic and allows runtime addition of memory regions,
 Linux guest virtual machines do not support accepting memory regions at ru=
ntime.
-Thus, memory regions should be provided before starting the VM and the VM
-configured to accept those memory regions at boot-up.
+Thus, memory regions should be provided before starting the VM and the VM =
must
+be configured to accept these at boot-up.
=20
-The guest physical address is used by Linux to check the requested user re=
gions
-do not overlap and to help find a corresponding memory region for calls li=
ke
-GH_VM_SET_DTB_CONFIG.
+The guest physical address is used by Linux kernel to check that the reque=
sted
+user regions do not overlap and to help find the corresponding memory regi=
on
+for calls like GH_VM_SET_DTB_CONFIG.
=20
 To delete a memory region, call GH_VM_SET_USER_MEM_REGION with label set t=
o the
-memory region of interest and memory_size set to 0.
+desired region and memory_size set to 0.
=20
-The flags field of gh_userspace_memory_region can set the following bits. =
All
+The flags field of gh_userspace_memory_region accepts the following bits. =
All
 other bits must be 0 and are reserved for future use. The ioctl will return
 -EINVAL if an unsupported bit is detected.
=20
-  - GH_MEM_ALLOW_READ/GH_MEM_ALLOW_WRITE/GH_MEM_ALLOW_EXEC sets read/write=
/exec permissions
-    for the guest, respectively.
-
-  - GH_MEM_LENT means that the memory will be unmapped from the host and b=
e unaccessible by
-    the host while the guest has the region.
+  - GH_MEM_ALLOW_READ/GH_MEM_ALLOW_WRITE/GH_MEM_ALLOW_EXEC sets read/write=
/exec
+    permissions for the guest, respectively.
+  - GH_MEM_LENT means that the memory will be unmapped from the host and be
+    unaccessible by the host while the guest has the region.
=20
 GH_VM_SET_DTB_CONFIG
 ~~~~~~~~~~~~~~~~~~~~
@@ -91,4 +88,4 @@ Resource Manager to allocate resources.
 GH_VM_START
 ~~~~~~~~~~~
=20
-This ioctl starts the virtual machine.
+This ioctl starts the VM.

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--hj7LpSjy5/N/rAip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY2Jq/gAKCRD2uYlJVVFO
owilAP9rOWj2RSc16xKy16v6rBpgFMf9kWpJ6RaRz4vJ/jImiAD9EL+mrL03+yCQ
uK+z+aXFFpnKScR58vO7PtNiq6SouAk=
=F0L1
-----END PGP SIGNATURE-----

--hj7LpSjy5/N/rAip--
