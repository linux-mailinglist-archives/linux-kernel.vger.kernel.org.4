Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F42C65DD86
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbjADUQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240099AbjADUQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:16:19 -0500
Received: from mx23lb.world4you.com (mx23lb.world4you.com [81.19.149.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708BF4085E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=C0bMdoWKeCFjYfejvYkmS+qO/S9NQwdBaH83mEYfQ5E=; b=p7ulw3/xTwepHz53Ltul6SJRaz
        lGNjsG19kWzebYll0Fs4DAYlL/645nv44DJZx14JzsjlJ66dII/GlcD0ntImAV+6IXSnCa39TBC/0
        LQfTIt6yppAy6IV7lV1GJ9azRZxDofMhj5V/08a/gKQy5KuzBRtVEusD4v6b4YxJIFyQ=;
Received: from [88.117.53.17] (helo=hornet.engleder.at)
        by mx23lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gerhard@engleder-embedded.com>)
        id 1pDAAf-0005Ib-8I; Wed, 04 Jan 2023 21:15:33 +0100
From:   Gerhard Engleder <gerhard@engleder-embedded.com>
To:     linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com,
        Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH v2] checkpatch: Ignore ETHTOOL_LINK_MODE_ enum values
Date:   Wed,  4 Jan 2023 21:15:24 +0100
Message-Id: <20230104201524.28078-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4104a20646 enum values like
ETHTOOL_LINK_MODE_Asym_Pause_BIT are ignored. But there are other enums
like ETHTOOL_LINK_MODE_1000baseT_Full_BIT, which are not ignored
because of the not matching '1000baseT' substring.

Add regex to match all ETHTOOL_LINK_MODE enums.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 78cc595b98ce..38659f22e54d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5783,6 +5783,8 @@ sub process {
 			    $var !~ /^(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]/ &&
 #Ignore Page<foo> variants
 			    $var !~ /^(?:Clear|Set|TestClear|TestSet|)Page[A-Z]/ &&
+#Ignore ETHTOOL_LINK_MODE_<foo> variants
+			    $var !~ /^ETHTOOL_LINK_MODE_/ &&
 #Ignore SI style variants like nS, mV and dB
 #(ie: max_uV, regulator_min_uA_show, RANGE_mA_VALUE)
 			    $var !~ /^(?:[a-z0-9_]*|[A-Z0-9_]*)?_?[a-z][A-Z](?:_[a-z0-9_]+|_[A-Z0-9_]+)?$/ &&
-- 
2.30.2

