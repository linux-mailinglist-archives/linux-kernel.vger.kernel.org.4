Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311935E596E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 05:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiIVDNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 23:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiIVDLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 23:11:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7B39019B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 20:10:28 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id v186so26790pfv.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 20:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KtJQxM97YBw1ybtvuETSvn7dCGYbbNyL/TMT/+SzmmU=;
        b=FXq499jerICaOIudNJl9X9HvncqoZ26Rey2ZEcTHwfOsxqpZ88m1AcMNvabITl7ktf
         otabATcFdrn9uUfQaBz54ORv9CLq2BALyhNuHATyi853KWeUJJODBiaOX2We8TBvbr3R
         089SGfE8g5vUSB25WVvFLrng0+Ij1LNA8tvzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KtJQxM97YBw1ybtvuETSvn7dCGYbbNyL/TMT/+SzmmU=;
        b=1ldm7EvZ4ergPuUMz8dI/2W3Uz9i86ZBAJ05WgLhfz70GMw1X2rOKgbp2U+FTq90kf
         70cqbQRSWJ9jiVVRNTt7hKtZ3KMU/l3fhc+EzciqyHPyt4J1uKNW9xkMWBCJTOusdC7P
         lhCgNl98sogpgRHnlpRRQQizC9F0jzgtaetjEHnfMg8oz9mT6L0YQ57Z/m8RlEFN0+J+
         mch4EDZbWy8RSnu0gvSuLUrhGx7rkSMfNmzUEaEGyvGw7yaeW2JJfS4nCigOvFNwIerr
         B7v9JzQviWFDxCoHK10J0wlMXOiJd+YOwNR91DU+uhNl2VixVoLLkKgHVh20I2Inbokw
         9M1g==
X-Gm-Message-State: ACrzQf24j8k37V6INNH84ba24+Jkx1JAX+O+QQPhDtD5doG+t3OzSLpa
        IXi+bGbOn+jXV3+n1QVJIeyJIA==
X-Google-Smtp-Source: AMsMyM5DFDxK0WCMKFDuZxvtbntvdP6o5W4EoaVjl4WwV6+EDjakr1hsYDIL2vLeT0yZPL8CvbXBgA==
X-Received: by 2002:a05:6a00:174f:b0:537:6845:8b1a with SMTP id j15-20020a056a00174f00b0053768458b1amr1476359pfc.68.1663816227626;
        Wed, 21 Sep 2022 20:10:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090a9b8200b002001c9bf22esm2650047pjp.8.2022.09.21.20.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 20:10:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Kees Cook <keescook@chromium.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alex Elder <elder@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Yonghong Song <yhs@fb.com>, Marco Elver <elver@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jacob Shin <jacob.shin@amd.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        dev@openvswitch.org, x86@kernel.org,
        linux-wireless@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 07/12] igb: Proactively round up to kmalloc bucket size
Date:   Wed, 21 Sep 2022 20:10:08 -0700
Message-Id: <20220922031013.2150682-8-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922031013.2150682-1-keescook@chromium.org>
References: <20220922031013.2150682-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355; h=from:subject; bh=GnGo60Q8Ey4t/45rZVkHHXQYJiJECnGYVFTtoXWQ73Y=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjK9ITjdxbzH7GftOj5prz+63FJ1nPbhwlH4IVeCtD 8ED2tMyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYyvSEwAKCRCJcvTf3G3AJjCiD/ wMJri5QLOOqouOEh6gNHJttRS42p0Og0uXHFXBpfBrQHVdMA/pZ7vM6aplEkCSzfpBRS9ns48N68wS jcAXVJGdtoRra0fSdkwT4D/eNkhKa/DLtxD0AIjix8HXBLfF0xblfFujjMTn2AcNU0TIoJNpYb7VgX k5ga7gxgqR6sqMlNaFb5qthk1BfSfBFjP5XdVSZtQjZHuc1xAXbYyBzlTYP5PHfAzBhZdVwZxDKAoh HLy++A+AphN0n4DVADlQ2Pn0+VZTZBXDRRAYBIKxn4mFfjNlexbTZx9K9vi+BB/QWW7WFQR851SPy2 H0AIW6jGUmqOlFp42ZjG32ra+NQrzMdB3SHS0UCKvWrHcgGOij3jZloSaDZ9TqEk86JUA2eNTV8EsO H2dRnVfemfa8X8YeGg5PS19OLC7pnOJYipxZfBdX5FrqP2SnHC2IqAqpLlOfeapo5yjFQdZZY/QeMW aYDixd+87XW69dT3Y8AMCAHA74UZNFOpQ96K/S/nwAMoGRQVUKRicu3fOrBwssRCIoAd24pldFMqg3 1lPT3qVVTF1IPhnR4vQ3RQJihuPUWjOP3S+3lH2U15ueKvZmGmjl7MCHI2RUE87+c+TqOb87PwG6fW eepaAJi+LmbVjbB1PG3ptYHjsDDSkTgUtQRqZ0fL/ZAxrsHf91M5rKLsQBig==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having a mismatch between the requested allocation size and
the actual kmalloc bucket size, which is examined later via ksize(),
round up proactively so the allocation is explicitly made for the full
size, allowing the compiler to correctly reason about the resulting size
of the buffer through the existing __alloc_size() hint.

Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 2796e81d2726..4d70ee5b0f79 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1196,6 +1196,7 @@ static int igb_alloc_q_vector(struct igb_adapter *adapter,
 
 	ring_count = txr_count + rxr_count;
 	size = struct_size(q_vector, ring, ring_count);
+	size = kmalloc_size_roundup(size);
 
 	/* allocate q_vector and rings */
 	q_vector = adapter->q_vector[v_idx];
-- 
2.34.1

