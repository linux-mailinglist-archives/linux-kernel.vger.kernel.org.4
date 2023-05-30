Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E256D717104
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjE3Wwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjE3Wwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:52:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC6DEC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:52:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d604cc0aaso4005604b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1685487156; x=1688079156;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M3rAYjkkHYPU/OK4ZEufLlpPfAsJjD+qxWbkdRp2kH4=;
        b=NuAS7EC5qFf3tPtS0R8PRJY2szySViFSxr9yxEUWX0Gyn4yt/lMZq5AKeJ92nCsjBK
         S8ID2zsOHwHXMr358b1Ols09P1lDR5fyFRNSrW5t4Yev5k80OPWWuNBONEP2aNaU/x5Y
         RPhu1L3vIOCgCL0UcQN8e1boC5uu6qJc7Rk0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487156; x=1688079156;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3rAYjkkHYPU/OK4ZEufLlpPfAsJjD+qxWbkdRp2kH4=;
        b=ZIoom6Zd38VJLhvNAuZIVha866CbMFEF+qGUO9qpd9bT2MFBCcalIXbZVLrzJYA0Xa
         A5hb867uEOxCWGD2MTliEO6tGXikylgioY0NrjfgEh+ttnk7EHH7BvnN8B1bgvJv3VzA
         vP6E+OCzU904YxG2+g50+v4ALCaxiUJ5Rrm17PIh9/tPfc6Wd7wk+u1fGiYTwT7j08xm
         go9Z3doXB/TLLpF7p3OBxvNBAex7i6BgZwtla25DI1NzVCikXBpiAfMh+WVY2jbAA7vm
         cACE4xQgQKrn5AdABGSyrtpjbRNZECW3yxYpRPY+A+Oqv7d9eiJggGxSI5tn/0TbW2lh
         T+ow==
X-Gm-Message-State: AC+VfDzLh/oTN2XjsVh07voAU/+KdHGqHslao6TcxpvR2zSJ8cz3k08O
        W9ohztBdVXWZmzQDK2cctwpLQQ==
X-Google-Smtp-Source: ACHHUZ5WlODrDTtoZX8GEYCbVj1jaRCwAA3DgwgGADMmFo2HRbK/qQRzvL7JF/EDSPcmpXzYCOp4Sw==
X-Received: by 2002:a17:903:644:b0:1af:babd:7b6d with SMTP id kh4-20020a170903064400b001afbabd7b6dmr3075052plb.52.1685487156127;
        Tue, 30 May 2023 15:52:36 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902b18300b001a1b66af22fsm10805011plr.62.2023.05.30.15.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:52:35 -0700 (PDT)
From:   Florian Fainelli <florian.fainelli@broadcom.com>
To:     stable@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
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
Subject: [PATCH stable 6.3 1/4] cacheinfo: Add use_arch[|_cache]_info field/function
Date:   Tue, 30 May 2023 15:49:11 -0700
Message-Id: <20230530224914.1251409-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530224914.1251409-1-florian.fainelli@broadcom.com>
References: <20230530224914.1251409-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003cf91105fcf10f5b"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003cf91105fcf10f5b
Content-Transfer-Encoding: 8bit

From: Pierre Gondois <pierre.gondois@arm.com>

commit ef9f643a9f8b62bcbcc51f0e0af8599adc2e17ed upstream

The cache information can be extracted from either a Device
Tree (DT), the PPTT ACPI table, or arch registers (clidr_el1
for arm64).

The clidr_el1 register is used only if DT/ACPI information is not
available. It does not states how caches are shared among CPUs.

Add a use_arch_cache_info field/function to identify when the
DT/ACPI doesn't provide cache information. Use this information
to assume L1 caches are privates and L2 and higher are shared among
all CPUs.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Link: https://lore.kernel.org/r/20230414081453.244787-5-pierre.gondois@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/base/cacheinfo.c  | 12 ++++++++++--
 include/linux/cacheinfo.h |  6 ++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index ea8f416852bd..8120ac1ddbe4 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -28,6 +28,9 @@ static DEFINE_PER_CPU(struct cpu_cacheinfo, ci_cpu_cacheinfo);
 #define per_cpu_cacheinfo_idx(cpu, idx)		\
 				(per_cpu_cacheinfo(cpu) + (idx))
 
+/* Set if no cache information is found in DT/ACPI. */
+static bool use_arch_info;
+
 struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu)
 {
 	return ci_cacheinfo(cpu);
@@ -40,7 +43,8 @@ static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 	 * For non DT/ACPI systems, assume unique level 1 caches,
 	 * system-wide shared caches for all other levels.
 	 */
-	if (!(IS_ENABLED(CONFIG_OF) || IS_ENABLED(CONFIG_ACPI)))
+	if (!(IS_ENABLED(CONFIG_OF) || IS_ENABLED(CONFIG_ACPI)) ||
+	    use_arch_info)
 		return (this_leaf->level != 1) && (sib_leaf->level != 1);
 
 	if ((sib_leaf->attributes & CACHE_ID) &&
@@ -343,6 +347,10 @@ static int cache_setup_properties(unsigned int cpu)
 	else if (!acpi_disabled)
 		ret = cache_setup_acpi(cpu);
 
+	// Assume there is no cache information available in DT/ACPI from now.
+	if (ret && use_arch_cache_info())
+		use_arch_info = true;
+
 	return ret;
 }
 
@@ -361,7 +369,7 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 	 * to update the shared cpu_map if the cache attributes were
 	 * populated early before all the cpus are brought online
 	 */
-	if (!last_level_cache_is_valid(cpu)) {
+	if (!last_level_cache_is_valid(cpu) && !use_arch_info) {
 		ret = cache_setup_properties(cpu);
 		if (ret)
 			return ret;
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 908e19d17f49..b91cc9991c7c 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -129,4 +129,10 @@ static inline int get_cpu_cacheinfo_id(int cpu, int level)
 	return -1;
 }
 
+#ifdef CONFIG_ARM64
+#define use_arch_cache_info()	(true)
+#else
+#define use_arch_cache_info()	(false)
+#endif
+
 #endif /* _LINUX_CACHEINFO_H */
-- 
2.25.1


--0000000000003cf91105fcf10f5b
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
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBHQ1JVQ+C48W79k
V1+NCGwLEK9eLXJC0NC6bfhEuz+rMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMDUzMDIyNTIzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDDb+Apaii5Gc/OIbtrgPeZqJ2VDoqh+Bzv
Zuo3kG/QbjGHWILx+Bd0wd4Kr1/rn+F+02G6Ftx0wKqG4OZ9Z509kkk1k17R6x0Pv1ePXpLuEp8v
0I46MaTJDgr7qhloCjqpDOKIHvppd506f3oNXEp1Gf8hAga80+2oJjq+CSBdU9+Wog4WtAzHLMeq
hGwjzJk1WnaQEFCB93pAqFhju/XYiPMIwO/Zk1/QQKg2DgN2e9wtMprBTGPtxOinKuVQJkNrVnqh
IWXkTa7fkfwHZvJFpMolHFoXUvmyUejdO+eGtnmxk2KjEHJeRaDaHHw3AbOI7CRD71ntD/ZKcTtc
m/ac
--0000000000003cf91105fcf10f5b--
