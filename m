Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC42E5B40A7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiIIU24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiIIU2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:28:25 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2138.outbound.protection.outlook.com [40.107.244.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4519712BF84;
        Fri,  9 Sep 2022 13:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8ehqQsNdjX9RVp6aOOw9HapF0B3Td5bEUZ2LQKwKhDUPT7XIzv91VV7i2Sy/3CZIxlZH+PFqQnQ0apOegZWQ5At0buR/8ImhuBZF6ndF4Tc4eblbthE9GoBU5ZlVs58GWTYw+HpNzCZLpDuISOa5Cmqa3PwmnF2sZBjv91vBWHryjW1ZRUmahujpJeexOP7XsSvx7IpJVPZDZS7qW+QRsOtIZcK4lMeWlf1UkEJY+p+scVX2IcYlMGUfbVOshjIow8HL2zcKv0TljhCLxWiqYX+DKUwndE4kJWtsXl/P+LLgVfcKQslNI1OP/1qnO1ZAK+Yag+CpifDfcG6tk1+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDepNO5EfQpFcyY5yYfCErgikCKTt5wPBJXCuNVFcDo=;
 b=DC4ZmDfzsJ+gMUIV3CkDhdUEtfYP+qH7yRLkeMxjZ6eAbz8009asVsWk9gLw+vpmE02b7uXKsNX6jg5ba5LgzlITwONXEeDZkP+8uGT3D3rY0T6IBRFdvTzSSjk07InzDH/Yr6W56BO5IZgx519nWLc4GKA/XL+qCj3UM4CtXAbUxoFM7jekjdymZ64yMMBK3OuOPh0Gspbrl+NfcbFCiOMzPA76ORSDfYu9LvnXtylm0a3cO+i0qSJhHnkI05mVeyRE452nAKk29WOSWA+AEQ+/pcgKbso4FOlArQjHAtVq9SAr4p7EVD3T49DnganaEP/NU3voANSYWHQzE1piCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDepNO5EfQpFcyY5yYfCErgikCKTt5wPBJXCuNVFcDo=;
 b=Oj/ElO06zfkUHwgFI3XTzEDC0SjvapgjWhv+2gcD9XS52Xw92h9uNU7UeNKzQ96zBDztVCbDeSlGWvq88AfhSr3WkXAPrmKtajU2qzTu/E9KxUWs8Q0NJuD4OjVCM4W3+aX3BLSFAv40RHV9y3VX8Jt6b6ACe+u8yqRUOWlO5vg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by SJ0PR13MB5426.namprd13.prod.outlook.com (2603:10b6:a03:420::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.11; Fri, 9 Sep
 2022 20:27:10 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7%3]) with mapi id 15.20.5612.011; Fri, 9 Sep 2022
 20:27:10 +0000
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     oss-drivers@corigine.com,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
Subject: [PATCH v5] checkpatch: warn for non-standard fixes tag style
Date:   Fri,  9 Sep 2022 22:25:34 +0200
Message-Id: <20220909202534.1857709-1-niklas.soderlund@corigine.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4431:EE_|SJ0PR13MB5426:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e679ba4-fd64-4d9c-786f-08da92a1ac52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFng7kpoFFiELFEqIjJ6bvJ/3a/BHkHuprl8+i/G6SWWGE9F+LuM/dJ9BY23wsU+ryeJu3Nu63XN+wG7fmG8rMhNAukdtsoe3cql+/ApHayliFMsm4ajL0eymq4A4k3o17Sn77TJ/llYhEb5EXTLCIekv3zYcUiN7Q7BRm6YMPTiRCbhnIlV4txa6J6oPMrYks84Faaev1UTXF+6iXpoc18QREhTgUJSbJUzV30vh4LVv6DKbQPLkYEwf2ogJqOsQ/Xbtsz1ujnVNBlUV/I6iFycq2JzvGEfmqw9W2wdV7f5dOdp+AhWvN6kamJH3tYODQKTG+i87D57kubZEJnUa3zrFS0sbUliGSADVmCU9dq9L+BTfkV93HRv/j2SXrd/K8etx3pjZ9Bisuaf79ijsvydBvfjtDL94fv7zIyAr1V+fa9rh94VQAEuFDnyXX8TjhF5XzF/s9IU1FrSuDyE1TYRGsb6aZw2dezZ7MALPzMRPX5hUoA9a1l+Nae8iuJijlIj80y3FLr5Ci0w/HpmVnwNMS/WiYStFs6xcodvfMhKzSEja1M1VanaWTLgAkGRrAwHa3+EXM4h2yCV4QLrnKwqLr0F4vuvZ3u05KW8G52AIupbEqlPeKHSn/W/YdYrIosBS0VaHJePu/IIazx0rUBEs5ge+xdVQjqFemZXINMvZYK8E0xXv/1c5aoX02O8RASZyDtwOh22gZNbr83dZnFFn1gNNhoGkTfQZnZf5EAFb1DRUldLGzbUalFJisH4jO9WYA5TXYNQMm+ZLQZSPhnUHlXDgT5krSdLH4GfrtY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(366004)(396003)(346002)(376002)(136003)(478600001)(83380400001)(26005)(110136005)(6666004)(52116002)(316002)(6506007)(54906003)(107886003)(5660300002)(36756003)(8936002)(2906002)(86362001)(4326008)(66476007)(66946007)(66556008)(6512007)(8676002)(66574015)(186003)(966005)(2616005)(6486002)(41300700001)(1076003)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3laSXJzRm1XZVFoTldYQ21mWTdKS2dGRUFXZ3hYSWwzSU1pWHpaOEkyM3hi?=
 =?utf-8?B?eTRhWUJ3K1RqM1NzdkpzUCtDRStVYVRIakdQL1VyMHBTZnR4OGRPWlRyNG50?=
 =?utf-8?B?T3NKUjlORGIwNCtwM2NWeCtHSVBwai83elJoQmIwTHR5dWttcHhPKzhGdEJl?=
 =?utf-8?B?NFJUd0Q4Y0NPNjVZeGY5WTFOWFB2WVNSWkJOQzJLQkNuVEM2Z0hHWHdVTnBV?=
 =?utf-8?B?bEpQWTIrd2gxek5qZ1dOZzB3YUVjV0RPQWh5VEtla1hkNUtVNkkvT2xlcnRn?=
 =?utf-8?B?Y0lid0c0eGRCdmFwaytWUlg5dkQwMHQvdWE5SWxkUmt5ckZ0Zk00Z3R5dmI5?=
 =?utf-8?B?R3JtRUtlMGxKbnltNDdiQ1NJeitYbHllcW9idFNlWHNMN3U5dXpTbDAyMjE1?=
 =?utf-8?B?SHBiamkwbndnS21oVlEyK3lTQU4rckdDOGNhZ21XRjR2dlJXVmptNHpYdTdq?=
 =?utf-8?B?THZ1WURQR1hDc0pMclRWV280alJKVzZhaUR1a3BCUW52NTFrYkc4ZGlsMHU2?=
 =?utf-8?B?TWVwR2hJWUs4Wk1zNjdpV1lQYlFCOXFVUzhYOGZ0VGtNRkZqK2hZU2R5aDg4?=
 =?utf-8?B?bGI0U25qbGc5U2ZocDRyNzkzaEJqNjZFcTJGeUhwazM1TEdsOFFNdmlYZ0Mx?=
 =?utf-8?B?bXU3N0ZzYXR1RU14c1dCRXZoV0RaSlZmNEsxYnhibGhpbFNSUWtyeldwTE1Y?=
 =?utf-8?B?TUk4ZDc3VXVoQ2FSS1doOXc2cXBCK0RnNEJjb0dzTURYekR4R2YvRDQwOUcr?=
 =?utf-8?B?M1kreDZwbDVobElTUVpZbkFZaHZBR05lOWZ5enNRZE45U0VCR2l0TzAzV0dQ?=
 =?utf-8?B?WmdSN1prWmlFRnl1NkVPcUdaMkViZHdSV0hlbTBhL21Cb0VaVXhlTC9MelVD?=
 =?utf-8?B?eW1JV25xWEFsYnhHaWJhdmhuMDR1WmxqVUlBeU5oZ1I1RC9mODJsbzBlRk4z?=
 =?utf-8?B?Nzg4ZjhnNjVjR0dCTHVHbWhFTS81U1g5NlhndEFCcFRJT294NUpVWFprSG44?=
 =?utf-8?B?SGJDQ2V6eTJOSW1DVTZhaWIycFBUVEIyb3U4aTFDcW1wY0E1RnN1R0F5eURs?=
 =?utf-8?B?QnNLRmdYWHpvQ05ta0tCVnN0UXI5d1E3RkYyT1BTQld0Y2hZZ3J6ODd1bGJw?=
 =?utf-8?B?akVybzV0ZFF0QWlTeXJZaHZBbVZremtkUmpucjk5LytBUG9hbm9yc3M1amQw?=
 =?utf-8?B?M2JUWjV0VWFISmh5N3laMWY4L3NjREFkUTBBSEZBMDUxNXFIRkZUT0hXTktE?=
 =?utf-8?B?Z0lrRlJHYmRXYWRQUGtIQUVXTy9URTZvS3A2YlUzWmNZR0RSdXQ3KzB1cjZ1?=
 =?utf-8?B?dnMreWJzSW4xbk05ZFNseVQxWDlGY1YwV0RiSTdzR1pqNU5PanNIV05JYlVj?=
 =?utf-8?B?dVQySk16bXBlYzQ5eGhBMnA5K0NERUliVDdhamtiN2pBeExUMXF3K2YrNmlz?=
 =?utf-8?B?ems4eVJaZ3F2a1JvYjhZQ3Y2V0laS2haWWhHZjVyOXV2cFZic2gxODBmc2dn?=
 =?utf-8?B?Nm1yV0lyR0RnUkFNWVVlZjFWRDlpRHZFUEt1dGtPbEl5OG1tb3cxalB0VTRD?=
 =?utf-8?B?NXltODJwWDZ5U2lMem01MTNadlBpMjZjcTFuZVZqZ25xYjVHOTBwMFd5T3l3?=
 =?utf-8?B?amlLMi9VTnE2bDBQWTB6dGpaeG1EUDFrYWFzVmJIYnAwd1FtMlFqU29IQ3ZM?=
 =?utf-8?B?ak5FWXhlOW16bzRiRGxhVTJKRW9oRlFMMUkyd05QRGQ0QlVoUnB1ZjRtRit6?=
 =?utf-8?B?WHVXS0pqTUUvLzhxNGVhQzdWRFo2L0F3NW4xcXcrMFFTUVg4WExydlFJSnlE?=
 =?utf-8?B?Y0FtYndaYXA5eUF3Q2JORVkzeWp2blZWUU1wb2laQjV2aXNvV1FKVUlvU0JL?=
 =?utf-8?B?TXB6dUFMOWxWQlptbHJVbzBGQ2ZMSGFWald3VWN1b1RVRHRJTlpNQ3Z2bWZa?=
 =?utf-8?B?WFF6cWltdTNNbFIzd1ZzVDVPRUNBam1NMmRLdm9WMWlJRE9rOTZHcGRubFVY?=
 =?utf-8?B?N0tYTmhoV1lmd0Nlek1oY2Z5TU1lL25ML1BwdVB0RG5rcGhGUTlPbmxvVVNR?=
 =?utf-8?B?TCtkdm9TUzVLOG1Ndk5UOTE1dk1aSS9RUnNWUFRSZ3U4NmxCWTN1RkdaNUZG?=
 =?utf-8?B?bSswajl6UTZuQkRuemNPVFB4QTZ5UEdnVkNQU0NaUGJVL0I0YWpmazlJYzha?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5426
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a warning for fixes tags that does not fall in line with the
standards specified by the community.

Signed-off-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Louis Peens <louis.peens@corigine.com>
---
* Changes since v4
- Extend test to cover lines with whitespace before the fixes: tag, e.g.
  match check on /^\s*fixes:?/i.

* Changes since v3
- Add test that title in tag match title of commit referenced by sha1.

* Changes since v2
- Change the pattern to match on 'fixes:?' to catch more malformed
  fixes tags.

* Changes since v1
- Update the documentation wording and add mention one cause of the
  message can be that email program splits the tag over multiple lines.
---
 Documentation/dev-tools/checkpatch.rst |  8 +++++
 scripts/checkpatch.pl                  | 41 ++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index b52452bc2963..8c8456a3bd18 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -612,6 +612,14 @@ Commit message
 
     See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
 
+  **BAD_FIXES_TAG**
+    The Fixes: tag is malformed or does not fall in line with the standards
+    specified by the community. This can occur if the tag have been split into
+    multiple lines (e.g., when pasted in email program with word wrapping
+    enabled).
+
+    See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
+
 
 Comparison style
 ----------------
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79e759aac543..61db5a46e254 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3140,6 +3140,47 @@ sub process {
 			}
 		}
 
+# Check Fixes: styles is correct
+		if (!$in_header_lines && $line =~ /^\s*fixes:?/i) {
+			my $orig_commit = "";
+			my $id = "0123456789ab";
+			my $title = "commit title";
+			my $tag_case = 1;
+			my $tag_space = 1;
+			my $id_length = 1;
+			my $id_case = 1;
+			my $title_has_quotes = 0;
+
+			if ($line =~ /(\s*fixes:?)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {
+				my $tag = $1;
+				$orig_commit = $2;
+				$title = $3;
+
+				$tag_case = 0 if $tag eq "Fixes:";
+				$tag_space = 0 if ($line =~ /^fixes:? [0-9a-f]{5,} ($balanced_parens)/i);
+
+				$id_length = 0 if ($orig_commit =~ /^[0-9a-f]{12}$/i);
+				$id_case = 0 if ($orig_commit !~ /[A-F]/);
+
+				# Always strip leading/trailing parens then double quotes if existing
+				$title = substr($title, 1, -1);
+				if ($title =~ /^".*"$/) {
+					$title = substr($title, 1, -1);
+					$title_has_quotes = 1;
+				}
+			}
+
+			my ($cid, $ctitle) = git_commit_info($orig_commit, $id,
+							     $title);
+
+			if ($ctitle ne $title || $tag_case || $tag_space ||
+			    $id_length || $id_case || !$title_has_quotes) {
+				WARN("BAD_FIXES_TAG",
+				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr);
+
+			}
+		}
+
 # Check email subject for common tools that don't need to be mentioned
 		if ($in_header_lines &&
 		    $line =~ /^Subject:.*\b(?:checkpatch|sparse|smatch)\b[^:]/i) {
-- 
2.37.3

