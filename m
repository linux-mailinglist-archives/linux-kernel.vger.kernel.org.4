Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25065B85E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiINKEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiINKD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:03:57 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2112.outbound.protection.outlook.com [40.107.95.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FA6696C9;
        Wed, 14 Sep 2022 03:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHrlcKxrcrCJ4YTzq1oWaSH5atSEU1fVabTqKO5+7KXbHXkKGoEkyipbXh4GQhpUhQrPnujW8Trj/00k+W3ywsm1nP08aL0fzDDORq5kaCGqJt7bDoXeWlzyIrgsjrQbyHPfNR37YXvsfim+dIIszS/F/3k2KupozmWSyHInG8zn4DmEpXXS7xhJXehkbEJhCeMzms6Zq5xX5XrI0zSlPGSFwwd6/oTs9j8+fginvMearokt7e7pTDnOLcr9/pxdqijh5051XBlQRXFY8/X1T1nnNM6ncOMxOmzVBkIpO3VHnqE/jk0H3u3/Tikgd46cTuJQJcZw7VDYFhls9e/WdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B/YI2dWEo5gi+8HFWWJuyb8fgKGOktOEcbpKD5s2Fo=;
 b=JfZpyCWthIbj8zoroxCTLT5W1qRC2CTP80L7NvXpxd8j/CbXVy/YP04Y1IbD5uKgXnkwB8qO62Bed91NDZEUpQ3rD1GHIKtzUve/xR4kmC3k9tqsHczepAa4TH8qLVEoPV27jzSu2B5t9qiR2aMgbxnxLE+ZckMetHn8GKUxM8V7NGOgfsotAcfNLmHyHM07+J/AnEe44FyPKb2AGcS+cFSBW/qggyoso7o9AIatGOk+hRmJXzB3Az9nxv4DWb89kd2gEssuthwyLq0cOgNJH7vAJxouf6TewhhdeZHtAQ/xslF08vNrViUW6IEZNtIHAv3Qzq+YiUVjSw1QBmgy9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4B/YI2dWEo5gi+8HFWWJuyb8fgKGOktOEcbpKD5s2Fo=;
 b=qOolaJW3HcW1pRqNCAFpPoODQ8zURoG4ywfsAg3nnf4V2MLohdcxW68k78i1AKXYrWgE+7cLxL1qAXLGacZWHA8ZsD7mXX1bAL4f6voNrY4C+Re+6ot9xDXmaDGRpSqkct3hAhnzEN5wgJmopC11YY3/nqCsToY7PrguUhjT4OY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by BLAPR13MB4690.namprd13.prod.outlook.com (2603:10b6:208:331::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12; Wed, 14 Sep
 2022 10:03:52 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7%3]) with mapi id 15.20.5632.012; Wed, 14 Sep 2022
 10:03:52 +0000
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
Subject: [PATCH v7] checkpatch: warn for non-standard fixes tag style
Date:   Wed, 14 Sep 2022 12:02:55 +0200
Message-Id: <20220914100255.1048460-1-niklas.soderlund@corigine.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::18) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4431:EE_|BLAPR13MB4690:EE_
X-MS-Office365-Filtering-Correlation-Id: 562f7b9e-a818-41cd-8623-08da96386d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gphSvz5qqGfJIsTm+gjxJrt2IOflwDDz7Phpk4llqsHaRAYU5ifDQ0kxdTD0q+nkGNxXCGfShjf+gGI/ICyInmlwS+SAKUIh1a6ZYFClxl20zuZiSOLo9ihakUsAKWVG++17/Zf4xhGNPpps4gEniaayymyLj+io5yJ7fbQMckM2QeKsVrO1bDF5myxERmgqvvNTBRy+BC1rN2udWo2GX2qVJ0s6GT2G8AhyOn+4aKIbWFg0m3qSQsiefCIbd7Ry4U2HLTdcjsBJmdwm0b+iFTNLqXyVs/xqmkpNcIGqFTKw0jpki6nxkK1m7cGxzz2H1QubRWLpxQ0z2UyWLlxw7ceCwxvU4e4Jm7Fe7R2tvItGYdmb7mmFVrnNrgi6c7EllVxAeXmAAPROA3064UaL1nBUlxVZPPbSDebn+LvMtOKsMabjdWm6b6K6dkVSbGYxSmZkR1dwzazXc16Z4PcTfpb6RGY0vcrgKY8r850V66Ve3Fb4eXeQOWJLGSG5MmwxW6p/s/HQ6W8BGXmLSgCrZyA2JA81OS8t5mMQyzoiPSxT8LUXD/aApptTFQ9QX8md27tvMjVd0v0wf8hu/knWdg4ZS4Jwws91IX5KUaI8Xk/BYztNZ02iqiixamX1ou5c+ty5TYWevhxuk31Rkh5q77NsPNEwrxX4e4vRWk/Qem+TbTOfMa+CQEOoURsVpQN6MurZUbdWanXS0zss5oLu8HKzGnstAAFOWoR+Y6rkcYX5KcPCRsrdWIyXIYmvRo9Oh5Cs4fppOVski54UiuSXjWcYPN92LN0UOlRDo4nDD4KNWp2v/fbt5ha/1DdZGcA1IhPJuW3NI4mOO7w3uyReSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(39830400003)(376002)(396003)(451199015)(26005)(66574015)(6512007)(38350700002)(110136005)(478600001)(52116002)(86362001)(6506007)(107886003)(83380400001)(8676002)(8936002)(2906002)(66556008)(38100700002)(66946007)(1076003)(2616005)(186003)(316002)(41300700001)(66476007)(4326008)(5660300002)(54906003)(36756003)(6486002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUxzRTJIczZzWk8vZkE5M1pjUjBIdmRMVXZQYzJEMC81ZUFja1dTMGdzSE5F?=
 =?utf-8?B?ZllNQk41dW9QZmhLa1JvUFB6ZzRNR1RZUGdnQnVKTWdLVU02c1RVYm4vUmo1?=
 =?utf-8?B?dGsrYkQ1MVFpVUFVaHV3V28rUmJtNHNuV3JibjltbHd2NWtYQ2hJcUpONndZ?=
 =?utf-8?B?RW9hSUFjNzAzM2EvY1l4bTQ3dGtxS01RVVpUNis0aUl1WEVhRFg3YWF1VGFX?=
 =?utf-8?B?d1MyNGZHc21YQzVpWnRISE9FZG5kVVF6d0RsdVF5M242OHB6L0NSV2RnU2tr?=
 =?utf-8?B?QzNUa1dTUUpBc1RuRjlqN2hCc3JtK3FMV2ZkNEpMMWdPZWdHcDVZbFVRbm5D?=
 =?utf-8?B?b1BkQUoyajArTDNqSDQrVmJobjZvQUJtNWN0Nlg0dFpWTU9PQkpReWIra1Jz?=
 =?utf-8?B?RndoUkVhWWJBaXRNdkFsV3Vobmk1SEVFdlNlcXJJdFhmTzZGLzZvQ2w1ekc1?=
 =?utf-8?B?Skw0YmNreVNET1VSTnhYQzhqRitSaFEvdVE2UiswTzRPMnV1aWtYYzVZRFps?=
 =?utf-8?B?bXBsK2JUdVMzU1NjbDhjRytkcFpoVnAxRHhtaVRqRElSYVhVbzhZek5QTWJx?=
 =?utf-8?B?QzhsUmJrbityTEtuZmlRTEc3V0RwT0JKVVBaUWxyRGd4OU1GU1c3MGVIU1hm?=
 =?utf-8?B?OFhaYXgycDV2bWs5VzJVRTRxUm1MS3k3SkxDZ3RQa1pCbTRRaStEZG55b040?=
 =?utf-8?B?RTRQdnh4bWZZbVpGQ1dzZG9pMkFMbFhIUWdmTkVyQzhZUkNhYUgwSWNwRjla?=
 =?utf-8?B?Yk9hQ0lPWHJZTFBxQ1crU1dlV2V6ZE1kSWtuUmQ0eldoZmErb0MvZ25IQVF1?=
 =?utf-8?B?MUlvVUF3ci9pNlpNREEybFFzNlVSNk0zKzQ3ejJiV1BaVTA4QlIzb2R2RGFk?=
 =?utf-8?B?TnJqb21JUkxMWldZaHJZRU5JMnF5Yjdta3dhZS9DTkMwVzA0NUlhYU5TaTBR?=
 =?utf-8?B?Sjcreml1ZmRTaGJPSEI2ZFpFTkxXWm9PaDZZS3dPOFoxWXRGeUFjNDQvMk1z?=
 =?utf-8?B?V3k5bkNHT2lxd2xwVEQrcDErR3BSd0NuZWt0WG81a2t4QjlmYWlCWlU5bjhW?=
 =?utf-8?B?VDM3NW5MUmFjNXF6M0l6ZWc3Q0pRWWtIZWNkUnBnTm1OKys1U09lRmlVT0dm?=
 =?utf-8?B?a1pLNU1BSlJEWG82QVBleWxhTTZJejRCT2NvNjUvY3lZWHM1SWw1N2ZqKzlX?=
 =?utf-8?B?TjYrRk9WSU0rWERYUklRbzBLQzh3Y0Ztc0dQVUk2TFk4b3pBeE5DSVFvS29p?=
 =?utf-8?B?WUI3WXZLNjFFUklHU1FERVNwZnh5N2g2bkZBUGM5RGp0V3c3WUVBVGxVbEJk?=
 =?utf-8?B?bmJXN3dRTUJtL2hJNVByUHYwSnkzMW8xNE9kK2NNdWh1VmhDWjJNcXN5a1Nt?=
 =?utf-8?B?aDN2UUhXWmdpYlBkdk1ueXZ3UnJLeTBNRnd1cDJ5UFFLY1d6V2tvSnBWRGN4?=
 =?utf-8?B?NVViZ1lMaXEyR3ZJUUw3MjlFazRFZjBHMGdINmhvRVg1aWIvZ0YzN0Z2aTE3?=
 =?utf-8?B?bHJRcHBnS29TYW16UlkrN3FVcmkzWURBMUFZSzRGVlp3R0xLT3BDOE1tUXdG?=
 =?utf-8?B?Q1dyWnVxQTY2Yk9RcWw1d2toZ3did2lWVzF3RG01NzlDYnR2Wmw1WEl2Q3px?=
 =?utf-8?B?VFVLdDdnZGIzL2FqUnJSNDhnemorR2NUL2dVRkhqMDFjaXJDa3RXbkFjSW9Y?=
 =?utf-8?B?cVFMTjcyZVhkUGpMcTRzYlBhZEZxOEFERXNuRFBnTlJZMVF0UVg0L1hnWWRt?=
 =?utf-8?B?dS9qWkpaelVGeVRBSkhzdWJUVVg3VjBzUDhvaU9Dd1FnYlptdXc4QXlYZERl?=
 =?utf-8?B?Yk1VOUc1NTFzMmpSeHNQaUVjdzdpV2RtMEwwZzRidE5wRTQ3ZENMSUd6OVZm?=
 =?utf-8?B?RmtxWDdpbjl1VUNPNEhWSU5SWlZpUXphTjdybDBTNlZxcjlDeEFHZE1XM3VW?=
 =?utf-8?B?Zlg3Ym83OUJ5RDhjNjRxSGRza0NnSk1jbzlRaWViR01VQUhxcW44bmprNzQy?=
 =?utf-8?B?NFk1bFh6ZVpsQUd4dFBUdUY2UjRkTVVZZFBHZzlQQjcwMGU4dmw5MktmY3hN?=
 =?utf-8?B?aTBuYnhGRnZLSHZFYkdDWmw0dTB3T2Ezb2VZcXRxTVFqOGFaMjlneUNsSTlD?=
 =?utf-8?B?cHJtQ2lDdFc5blVDakJ3U3BJcmdnNmh1Q3VvRitiVXRQeTUyYVMyaDQyY0pL?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4690
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a warning for fixes tags that does not follow community conventions.

Signed-off-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Louis Peens <louis.peens@corigine.com>
Reviewed-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Acked-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
* Changes since v6
- Update first check to make sure that there is a likely SHA1 of some
  minimum length after the fixes line.
- s/fall in line with community standard/follow community conventions/.
- Improve grammar, thanks Lukas.

* Changes since v5
- Add support for --fix option for checkpatch.pl.

* Changes since v4
- Extend test to cover lines with whitespace before the fixes: tag, e.g.
  match check on /^\s*fixes:?/i.

* Changes since v3
- Add test that title in tag match title of commit referenced by sha1.

* Changes since v2
- Change the pattern to match on 'fixes:?' to catch more malformed
  tags.

* Changes since v1
- Update the documentation wording and add mention one cause of the
  message can be that email program splits the tag over multiple lines.
---
 Documentation/dev-tools/checkpatch.rst |  7 ++++
 scripts/checkpatch.pl                  | 44 ++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index b52452bc2963..c3389c6f3838 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -612,6 +612,13 @@ Commit message
 
     See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
 
+  **BAD_FIXES_TAG**
+    The Fixes: tag is malformed or does not follow the community conventions.
+    This can occur if the tag have been split into multiple lines (e.g., when
+    pasted in an email program with word wrapping enabled).
+
+    See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
+
 
 Comparison style
 ----------------
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79e759aac543..ddc5c9d730c3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3140,6 +3140,50 @@ sub process {
 			}
 		}
 
+# Check Fixes: styles is correct
+		if (!$in_header_lines &&
+		    $line =~ /^\s*fixes:?\s*(?:commit\s*)?[0-9a-f]{5,}\b/i) {
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
+				if (WARN("BAD_FIXES_TAG",
+				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
+				    $fix) {
+					$fixed[$fixlinenr] = "Fixes: $cid (\"$ctitle\")";
+				}
+			}
+		}
+
 # Check email subject for common tools that don't need to be mentioned
 		if ($in_header_lines &&
 		    $line =~ /^Subject:.*\b(?:checkpatch|sparse|smatch)\b[^:]/i) {
-- 
2.37.3

