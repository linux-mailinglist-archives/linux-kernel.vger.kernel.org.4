Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B792717108
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjE3Www (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjE3Wwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:52:46 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968DEE5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:52:38 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53f158ecfe1so3248198a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1685487158; x=1688079158;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=H1GvWOqlx1Dba3LiJHI+NPU6JZQpvgSU+CIWyzMBP7I=;
        b=d0sIt0bv54RazJVOFmukPNDKUZZVBdRhKdo/K75HJL+5u/30i83c8V1NO8sfXRxbZk
         v3ACtsy/KOQBe1STqCpWx9BT+NXhCBL3D+DoKgL2bxgQ2gOd+11y/bDjfbQef5hNS3tL
         AGVyfqaLfuLcHPBOCvDjtF02KOoTdNUl9Nf5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487158; x=1688079158;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1GvWOqlx1Dba3LiJHI+NPU6JZQpvgSU+CIWyzMBP7I=;
        b=NGB2WWiXrrlWV97Kf813+lTxQLw8j8q31nMm4lS1qsZ6VoJ4GaW6Eib0bGxz4QiJlh
         NC8mQtwJHs6fPyocXLuptARD4gHC5vQ0WlCkicnFM6+Q9Dx3ScimDp56QGwPSyY/h+ni
         8hmYY/4huuGpxL6XiQxdRXioexYfqrBwgZp/u8yqRD/+XKl8Uk9I8YF99RY3nUkcjN8E
         hlsR8ld9pLoY6mtsBlp2++OwvREnPPcV24rhynMbM3RMjx/vMBA6CO+i/gfLaJMq/y0o
         aVv20yWalSrDtgxk/uzbGRnIJZ/3Eo630+V4InMS4/xwEz5YgFXefwXCRFH5Nj1xqYG3
         ixiQ==
X-Gm-Message-State: AC+VfDxV+P7dr/g6sZnq+dSUpOo72Mhs4n419oODcIeu/GMsao9Yqrjs
        MNdK4gndYiaR0EgVaKzAvrE4Kg==
X-Google-Smtp-Source: ACHHUZ7p0z/7plvKaPmSEwuXlrMuKxmrxEyHJQcQ2QyrDBRLq8oOOkvnsaHlJ7Ttqk8YcW3JKL29ow==
X-Received: by 2002:a17:903:24d:b0:1af:c599:6a88 with SMTP id j13-20020a170903024d00b001afc5996a88mr4362450plh.49.1685487157968;
        Tue, 30 May 2023 15:52:37 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902b18300b001a1b66af22fsm10805011plr.62.2023.05.30.15.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:52:37 -0700 (PDT)
From:   Florian Fainelli <florian.fainelli@broadcom.com>
To:     stable@vger.kernel.org
Cc:     Radu Rendec <rrendec@redhat.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH stable 6.3 2/4] cacheinfo: Add arch specific early level initializer
Date:   Tue, 30 May 2023 15:49:12 -0700
Message-Id: <20230530224914.1251409-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530224914.1251409-1-florian.fainelli@broadcom.com>
References: <20230530224914.1251409-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000058e95205fcf10f9b"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000058e95205fcf10f9b
Content-Transfer-Encoding: 8bit

From: Radu Rendec <rrendec@redhat.com>

commit 6539cffa94957241c096099a57d05fa4d8c7db8a upstream

This patch gives architecture specific code the ability to initialize
the cache level and allocate cacheinfo memory early, when cache level
initialization runs on the primary CPU for all possible CPUs.

This is part of a patch series that attempts to further the work in
commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU").
Previously, in the absence of any DT/ACPI cache info, architecture
specific cache detection and info allocation for secondary CPUs would
happen in non-preemptible context during early CPU initialization and
trigger a "BUG: sleeping function called from invalid context" splat on
an RT kernel.

More specifically, this patch adds the early_cache_level() function,
which is called by fetch_cache_info() as a fallback when the number of
cache leaves cannot be extracted from DT/ACPI. In the default generic
(weak) implementation, this new function returns -ENOENT, which
preserves the original behavior for architectures that do not implement
the function.

Since early detection can get the number of cache leaves wrong in some
cases*, additional logic is added to still call init_cache_level() later
on the secondary CPU, therefore giving the architecture specific code an
opportunity to go back and fix the initial guess. Again, the original
behavior is preserved for architectures that do not implement the new
function.

* For example, on arm64, CLIDR_EL1 detection works only when it runs on
  the current CPU. In other words, a CPU cannot detect the cache depth
  for any other CPU than itself.

Signed-off-by: Radu Rendec <rrendec@redhat.com>
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Link: https://lore.kernel.org/r/20230412185759.755408-2-rrendec@redhat.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/base/cacheinfo.c  | 75 +++++++++++++++++++++++++++------------
 include/linux/cacheinfo.h |  2 ++
 2 files changed, 55 insertions(+), 22 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 8120ac1ddbe4..14aa62c3f10f 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -437,6 +437,11 @@ static void free_cache_attributes(unsigned int cpu)
 	cache_shared_cpu_map_remove(cpu);
 }
 
+int __weak early_cache_level(unsigned int cpu)
+{
+	return -ENOENT;
+}
+
 int __weak init_cache_level(unsigned int cpu)
 {
 	return -ENOENT;
@@ -462,56 +467,82 @@ int allocate_cache_info(int cpu)
 
 int fetch_cache_info(unsigned int cpu)
 {
-	struct cpu_cacheinfo *this_cpu_ci;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	unsigned int levels = 0, split_levels = 0;
 	int ret;
 
 	if (acpi_disabled) {
 		ret = init_of_cache_level(cpu);
-		if (ret < 0)
-			return ret;
 	} else {
 		ret = acpi_get_cache_info(cpu, &levels, &split_levels);
-		if (ret < 0)
+		if (!ret) {
+			this_cpu_ci->num_levels = levels;
+			/*
+			 * This assumes that:
+			 * - there cannot be any split caches (data/instruction)
+			 *   above a unified cache
+			 * - data/instruction caches come by pair
+			 */
+			this_cpu_ci->num_leaves = levels + split_levels;
+		}
+	}
+
+	if (ret || !cache_leaves(cpu)) {
+		ret = early_cache_level(cpu);
+		if (ret)
 			return ret;
 
-		this_cpu_ci = get_cpu_cacheinfo(cpu);
-		this_cpu_ci->num_levels = levels;
-		/*
-		 * This assumes that:
-		 * - there cannot be any split caches (data/instruction)
-		 *   above a unified cache
-		 * - data/instruction caches come by pair
-		 */
-		this_cpu_ci->num_leaves = levels + split_levels;
+		if (!cache_leaves(cpu))
+			return -ENOENT;
+
+		this_cpu_ci->early_ci_levels = true;
 	}
-	if (!cache_leaves(cpu))
-		return -ENOENT;
 
 	return allocate_cache_info(cpu);
 }
 
-int detect_cache_attributes(unsigned int cpu)
+static inline int init_level_allocate_ci(unsigned int cpu)
 {
-	int ret;
+	unsigned int early_leaves = cache_leaves(cpu);
 
 	/* Since early initialization/allocation of the cacheinfo is allowed
 	 * via fetch_cache_info() and this also gets called as CPU hotplug
 	 * callbacks via cacheinfo_cpu_online, the init/alloc can be skipped
 	 * as it will happen only once (the cacheinfo memory is never freed).
-	 * Just populate the cacheinfo.
+	 * Just populate the cacheinfo. However, if the cacheinfo has been
+	 * allocated early through the arch-specific early_cache_level() call,
+	 * there is a chance the info is wrong (this can happen on arm64). In
+	 * that case, call init_cache_level() anyway to give the arch-specific
+	 * code a chance to make things right.
 	 */
-	if (per_cpu_cacheinfo(cpu))
-		goto populate_leaves;
+	if (per_cpu_cacheinfo(cpu) && !ci_cacheinfo(cpu)->early_ci_levels)
+		return 0;
 
 	if (init_cache_level(cpu) || !cache_leaves(cpu))
 		return -ENOENT;
 
-	ret = allocate_cache_info(cpu);
+	/*
+	 * Now that we have properly initialized the cache level info, make
+	 * sure we don't try to do that again the next time we are called
+	 * (e.g. as CPU hotplug callbacks).
+	 */
+	ci_cacheinfo(cpu)->early_ci_levels = false;
+
+	if (cache_leaves(cpu) <= early_leaves)
+		return 0;
+
+	kfree(per_cpu_cacheinfo(cpu));
+	return allocate_cache_info(cpu);
+}
+
+int detect_cache_attributes(unsigned int cpu)
+{
+	int ret;
+
+	ret = init_level_allocate_ci(cpu);
 	if (ret)
 		return ret;
 
-populate_leaves:
 	/*
 	 * If LLC is valid the cache leaves were already populated so just go to
 	 * update the cpu map.
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index b91cc9991c7c..a5cfd44fab45 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -76,9 +76,11 @@ struct cpu_cacheinfo {
 	unsigned int num_levels;
 	unsigned int num_leaves;
 	bool cpu_map_populated;
+	bool early_ci_levels;
 };
 
 struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
+int early_cache_level(unsigned int cpu);
 int init_cache_level(unsigned int cpu);
 int init_of_cache_level(unsigned int cpu);
 int populate_cache_leaves(unsigned int cpu);
-- 
2.25.1


--00000000000058e95205fcf10f9b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJyXtgaHchUUCMV+
X5iE7LBMh5AzAs7zJ2KkMyWwRgjgMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMDUzMDIyNTIzOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBYtyoOccUGdUqfS9Y63Uvh8PWm2vGjCGf6
mWihdvpf33cU8M4Afkd3JHjNsgFl/fjWdD0fE0MyghUiMwRqHF4jDq1HhRrdGmp8uz2qg0/7QLwp
/lSSbWNiB6p4pKqLjnV7IaJ5/EtwUWvl5K2l34dt6DbgTHrunM2YT4gwIc7PqK6ioksBS8KU5K5g
0MxmMnaOc+9xFP5WUe0rl8T4ofrCPECNbm9ZzJUpGbbK6X7kmXoO5eGZcHgSbZxQhgRV982uSmkM
6cbjfZhcJZx0SC4X9XEwL454orKLAVIPPGI/av8A7paKBmrmsQmdud4c5bHBLJWkr2XCcf/N8Uy2
dxrD
--00000000000058e95205fcf10f9b--
