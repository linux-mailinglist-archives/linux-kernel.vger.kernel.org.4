Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFBE68EF81
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjBHNIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBHNIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:08:10 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2144F46D6A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 05:08:04 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230208130800euoutp01464ea33fba553150818e3f801a0c793f~B21HORDfm0729407294euoutp01G
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 13:08:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230208130800euoutp01464ea33fba553150818e3f801a0c793f~B21HORDfm0729407294euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675861680;
        bh=NkEieWj4aKUt96PeZd1bqkfzO/gq34U0pcl+tnglNUI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=A4M0iwJJbEftcHv7IQbIYKmO/2dG399k28Ha7aob8a0Eowddelek/H8ukUSOR2bp2
         p503nVliZaq9D9WmInoT3A+aHvrWZoUYMbX8Ow669v/xDmUQ3xVrY6KkovMnyiiMA9
         Qnk5IJXNnTtVmKcYw4oyoAZhB6xQ9WSG9m20Tnl8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230208130800eucas1p15c541fcab51c8e22b3b0847eb7145c98~B21HBM4XZ2912229122eucas1p1V;
        Wed,  8 Feb 2023 13:08:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 55.B5.01471.0BE93E36; Wed,  8
        Feb 2023 13:08:00 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230208130800eucas1p2fbcba741dbd7483bb0a9b2d4b6c6dbfd~B21Gq6z360495104951eucas1p2z;
        Wed,  8 Feb 2023 13:08:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230208130800eusmtrp13a60800edbd9df7c0d18e10bec8fb70e~B21Gkmfd11465714657eusmtrp1M;
        Wed,  8 Feb 2023 13:08:00 +0000 (GMT)
X-AuditID: cbfec7f2-2b1ff700000105bf-d9-63e39eb07fc1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 54.47.02722.FAE93E36; Wed,  8
        Feb 2023 13:07:59 +0000 (GMT)
Received: from localhost (unknown [106.120.51.111]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230208130759eusmtip1f0e4adb3d8f60d785b1d4b36f8c67945~B21GYJZ2A1152411524eusmtip1M;
        Wed,  8 Feb 2023 13:07:59 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] merge_config.sh: do not report some differencess between
 input and output
Date:   Wed,  8 Feb 2023 14:07:31 +0100
Message-Id: <20230208130732.63172-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
X-Developer-Signature: v=1; a=openpgp-sha256; l=2893;
        i=l.stelmach@samsung.com; h=from:subject;
        bh=ljJ8pdV8ot5fsQIHCmsxZhK0/bwnqKfQLWVxPbc7Jag=;
        b=owEBbQGS/pANAwAIAbCuHpyYpYAQAcsmYgBj456TTgtcXeJlSAO5UF/8PpdGefmnuc/BOEeEQ
        kAmmZeAKL+JATMEAAEIAB0WIQRem7KqOr2QYRWv1RCwrh6cmKWAEAUCY+OekwAKCRCwrh6cmKWA
        EEGACACkXZiwHDXmtv5Z3phxrzPm5KTIDif7qPim+El7+ThBFyqTzugCz/31SvWZl/ucLxaUbgF
        exc7x5pMwiA5j3h6OCrmF7szN9XDn1/luaHyBhJuIJsY1UFudTwIyp1JWjP0d8TcU8aULSvKtRk
        nxf/wjU7+Of5xOTjTg+ExmS+whLRIkiMiF2sICpFFjh2JDX5lq8rKUroL1BtL9M9yaKjsgcjUcW
        1n1+uFME9g4wyZFkv2mkhnoHXNIphN61uwOvZ6j3ZFnKwRA3ReyP/80ERYfmcQb0c/EZKwHZdfx
        Z/NQUWDyBlusP1gmpMgVt6NORiW0oRw7LeqA6iKwSKhhexiM
X-Developer-Key: i=l.stelmach@samsung.com; a=openpgp;
        fpr=A2B9843766B15A4D32BCBF0DEC1B3A02E80CD5C8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djPc7ob5j1ONri/Vsbi5qEVjBZ/du1g
        sri8aw6bxdojd9ktHj64werA6rFpVSebR9+WVYwenzfJBTBHcdmkpOZklqUW6dslcGWs3ptb
        cF6s4tfSh6wNjOcEuxg5OSQETCTurlrE2sXIxSEksIJR4tfM02wQzhdGiabZexkhnM+MEhef
        7GGCaVn9p4cVxBYSWM4o8e0zP0TRC0aJVR8bwIrYBBwl+peeACsSEdCSuLO0A2wHs8AaRonL
        /deBijg4hAXiJQ7NywSpYRFQlVj8opcFxOYVsJZ49e4kC8QyeYm269MZIeKCEidnPgGL8wPN
        XNN0nQVkpoTAbFaJJ+dvsEI0pEg8vNwK1sAM1Ny8dTYzRNEBDomtx6+yQxS5SGzo28QMYQtL
        vDq+BSouI3F6cg/U1HZgAFxZyArhTGCU+NzRBA0Aa4k7536xgbzALKApsX6XPkTYUeLurp8s
        IGEJAT6JG28FIY7gk5i0bTozRJhXoqNNCKJaRWJd/x6WCYzKs5D8NgvJ2bMQ5i9gZF7FKJ5a
        WpybnlpsmJdarlecmFtcmpeul5yfu4kRmERO/zv+aQfj3Fcf9Q4xMnEwHmKU4GBWEuH9PvFx
        shBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFebduTyUIC6YklqdmpqQWpRTBZJg5OqQamopwjyw2f
        /Xd2n63LYLA/rmfKzAOS/69oWJV6CT7vU52zNnLGbJErXewnLkVyeIe+nS140+6SWMQhl7QJ
        i+/m3OD23jp5ppeA0Bl7w3vrfmupHNU8envr6YPz5HhmbQrqkHZZNk/xQbQEp7rJOau6HXUq
        MaIL9E+YxDqKzNj9ZOeLNVbLna8vfxB6LvfhDWbnW19VLRTDd539ZPD0pHlzoGHJnfDz3GHH
        fDZr1H2zub5gZ8C2hxVM7T/fGk5oOzB3zaef0/PEf5oZns0wOS58wH0R32/l6vf/VIPnMX+6
        JN5+gTvgp7BAXOWaRV2WK9r2HLryS1gt5vMh0xt/WJ9dKe37HL7L/lfihj97OhMN5ZRYijMS
        DbWYi4oTAaJ+ZtSRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42I5/e/4Xd318x4nG7y4amVx89AKRos/u3Yw
        WVzeNYfNYu2Ru+wWDx/cYHVg9di0qpPNo2/LKkaPz5vkApij9GyK8ktLUhUy8otLbJWiDS2M
        9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJW780tOC9W8WvpQ9YGxnOCXYycHBIC
        JhKr//SwdjFycQgJLGWUmPf1FWMXIwdQQkpi5dx0iBphiT/Xutggap4xSmycd5wVJMEm4CjR
        v/QEmC0ioCVxZ2kH2CBmgXWMEnOn/mQHSQgLxEr8vDUZzGYRUJVY/KKXBcTmFbCWePXuJAvE
        BnmJtuvTGSHighInZz5hATmCWUBdYv08IZAwP9D8NU3XWUDmSwh0skrc+7CQHaI3SeLA+nVg
        vcxAc5q3zmaewCg0C8moWQijZiGpWsDIvIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwYrYd
        +7l5B+O8Vx/1DjEycTAeYpTgYFYS4f0+8XGyEG9KYmVValF+fFFpTmrxIUZToNcmMkuJJucD
        YzavJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoGJYaLVZI7NdXcn
        BlctrrIJXblWIeI0U9Kh5Vq5uhNb33bKyjefXezWsXWaPVd4YfDCNWfPTbqp+tzJdplchX2y
        tXZXDyPTjnkcd2bWavRbnuA/d9/V+H7cnOrHh27K+/5eF7p8Cj9T9Ply74mhEel/1IMY7VSX
        CGobfvo67/K7xs03Tp5PvX5/alu04qRbn2Z8KPH8UGIweWpfcSgX+3nZNXxzc1r6kl+fMC5p
        9dywboVEZPHKz8f9LNfEst6uas+64PvKYXZhNte5qc+qY+ecXrTE2CXofaCz22HT7Vd2SP27
        LHHbfXbOPnu9bROafgVs4ly7wuOXxsfgH5OPKM2RuROWUr+Vo/797KwXhgn7lFiKMxINtZiL
        ihMBiOpjGSEDAAA=
X-CMS-MailID: 20230208130800eucas1p2fbcba741dbd7483bb0a9b2d4b6c6dbfd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230208130800eucas1p2fbcba741dbd7483bb0a9b2d4b6c6dbfd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230208130800eucas1p2fbcba741dbd7483bb0a9b2d4b6c6dbfd
References: <CGME20230208130800eucas1p2fbcba741dbd7483bb0a9b2d4b6c6dbfd@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an input config file contains CONFIG_FOO=n the output one
will contain a line '# CONFIG_FOO is not set'. merge_config.sh
should not report it as difference because the end result of
CONFIG_FOO being disabled is achieved.

Inexistence of CONFIG_FOO (because of unment dependencies) in case
CONFIG_FOO=n is requested, should also be ignored.

Change-Id: I129f3a0b4205a76d8c42020f8adb72b1889d75fb
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
Changes in v2:
- suppress reports reports if an option was "not set" in input files
  but is missing from the filnal .config due to unmet dependecies.
- apply the same logic to suppress some reports during the merging
  phase

BTW. Do you think adding "| sort -u" after "grep -w" to avoid reports
about repeated entries may make sense or do you want such reports to
be printed.

 scripts/kconfig/merge_config.sh | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index e5b46980c22a..1086bdc7abf2 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -144,12 +144,17 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
 			echo
 			BUILTIN_FLAG=true
 		elif [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
-			echo Value of $CFG is redefined by fragment $ORIG_MERGE_FILE:
-			echo Previous  value: $PREV_VAL
-			echo New value:       $NEW_VAL
-			echo
-			if [ "$STRICT" = "true" ]; then
-				STRICT_MODE_VIOLATED=true
+			if [ \( "x$PREV_VAL" != "x$CFG=n" -a \
+				"x$PREV_VAL" != "x# $CFG is not set" \) -o \
+			     \( "x$NEW_VAL" != "x"  -a \
+				"x$NEW_VAL" != "x# $CFG is not set" \) ]; then
+				echo Value of $CFG is redefined by fragment $ORIG_MERGE_FILE:
+				echo Previous  value: $PREV_VAL
+				echo New value:       $NEW_VAL
+				echo
+				if [ "$STRICT" = "true" ]; then
+					STRICT_MODE_VIOLATED=true
+				fi
 			fi
 		elif [ "$WARNREDUN" = "true" ]; then
 			echo Value of $CFG is redundant by fragment $ORIG_MERGE_FILE:
@@ -196,9 +201,14 @@ for CFG in $(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2" $TMP_FILE); do
 	REQUESTED_VAL=$(grep -w -e "$CFG" $TMP_FILE)
 	ACTUAL_VAL=$(grep -w -e "$CFG" "$KCONFIG_CONFIG" || true)
 	if [ "x$REQUESTED_VAL" != "x$ACTUAL_VAL" ] ; then
-		echo "Value requested for $CFG not in final .config"
-		echo "Requested value:  $REQUESTED_VAL"
-		echo "Actual value:     $ACTUAL_VAL"
-		echo ""
+		if [ \( "x$REQUESTED_VAL" != "x$CFG=n" -a \
+		        "x$REQUESTED_VAL" != "x# $CFG is not set" \) -o \
+		     \( "x$ACTUAL_VAL" != "x"  -a \
+			"x$ACTUAL_VAL" != "x# $CFG is not set" \) ]; then
+			echo "Value requested for $CFG not in final .config"
+			echo "Requested value:  $REQUESTED_VAL"
+			echo "Actual value:     $ACTUAL_VAL"
+			echo ""
+		fi
 	fi
 done
-- 
2.30.2

