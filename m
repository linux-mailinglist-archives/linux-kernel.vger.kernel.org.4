Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8595B4541
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 10:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiIJIjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 04:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIJIi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 04:38:58 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2123.outbound.protection.outlook.com [40.107.102.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADE61114A;
        Sat, 10 Sep 2022 01:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdVXYUFng99fPHp+5DGm61DXOoH/DMo9d39fezyqg9sLSgsS6ZExVKQqhXK+j9KOcNuKMfmB2ld3/onG24WzNR7NtWRgNohS6MtDNJxVQ2cPN7WOOPkajFqba+ai29CRbJF688lxUQFDjsDl4v/7sO5Z6tVPZRJDu389yU30nCmrmKFvCt0Y+vXqhonJq0RJaVZXlEyazZt00DjbXmFllN/VMpym79cjhr4ulklu3fuI2zqFLc4Z9HetKGmpuk1mhl4fPkfv8u1UEBcHwQD98nWcRA3pKp7bCXJX73NFngHW7Buv3mj34yunTxNdga7lfvx49TkRw1RgW/ZtfrPKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyfXV9G+R62BMVg+qlbKdRGdRnS+LINQSCo8b+M+AVg=;
 b=TECAStcBI5IBqsLdJsW9Hjbf7+ZBMMI5zkF6VPmb2okhdPBbYI/EtKDYe6CQ6SW1omO28mPzNC6pyEgdP4OjmB1cktB/VXzafcBFp2aV8FDPArT3vxgboIPKXPJTh0dLf0khd8vLUtArQZEf+gPXOnk2Dab6RQOM7rtbNM0BSbDWwThk++rpkXLpTUO+LJ6bcUbuVPya4KaTqwd2B+SbHDjH713YVl0jijb76gWYrZCWvJQBeFYpm5KMg1O8f9BJD8NGykaCUdFVip02ALYmgjfi+9IUhIPR3loR8LbFvako0T5AXZ+D+5eFCUNCZPfo6PKtVy9j1g2UZAir/eqq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyfXV9G+R62BMVg+qlbKdRGdRnS+LINQSCo8b+M+AVg=;
 b=PbFz46CEDl9fU3XvXwpoxSv286qEA4g+azBPh4TiJWbgNHbeDLueSSJhjebejAwlSdpS+6Ia9h1Xu6/shAiP0lj5sVRiVLsk8/CeCAO8Y18G2Q4DlyR7iGM6n5hf325cA4ag6wjPBR2fMLsPIpZ2wKIZSfAnPjql9xK+U67j9uc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by BL3PR13MB5075.namprd13.prod.outlook.com (2603:10b6:208:33e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.6; Sat, 10 Sep
 2022 08:38:52 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7%3]) with mapi id 15.20.5612.011; Sat, 10 Sep 2022
 08:38:52 +0000
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
Subject: [PATCH v6] checkpatch: warn for non-standard fixes tag style
Date:   Sat, 10 Sep 2022 10:38:35 +0200
Message-Id: <20220910083835.2219239-1-niklas.soderlund@corigine.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::18) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4431:EE_|BL3PR13MB5075:EE_
X-MS-Office365-Filtering-Correlation-Id: f75497f4-3106-4fd3-76f2-08da9307e3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RjqKlqFC9os0yQ3M2XC3kjCms6zB4m/mFxZhOZ4PFL9CsALXm3N0kQ3CbZKSeW9+YS36ZLwb2qUqxJ9kRiGKIy5V+6txvj/DTO6UR8ri3ImcEzX3FhBWCkl8rt5aibxfsi0mG9yMEcvyqk0b5PaGsrAcmWgNjYe/1AainXHf+xC+M2zYwoPFreQLyazRaigwICvH6cTWAOxLFegXCknrec4V+ADrx0dTpR9SDkSA/2H5LMZVi017LrloPAAbmMpDlFTQzeWO9X75t98S+r4SKUrZ3DJbft80dR4Rv3dIdGilREzdBVFDJmGq75E+QSAPAPAbcPRI0lGoNWeBDfwsIYsvbsna3M3m5krxpbjWJYFa6zmgSNEnuWlKRLGP85BDQkVIiVVaoJsR8gcGOhxocmoa1zmheBu30objSyCmoel4blnh1Imo9gvznQ6S+vM+E9KcgykavrEIER9ljiW6Wv7Ly8Ay0++thuX6/xNbvw9sfVNo13YYOsSspnxH/GHiUTrJf9ZMeIEtRkVl4U4wIHHTSSwjfZHYgisGl5BzBFA+Qm3w8sw5QeKaUNkw5apBUdfYyeYT0W+xySfBEZt67p10RmjpgNQdo4XZKhOZBJrtKGd7SCa8KVLSJoezuomBP7o+nWSkQ2WIARidOi10C3IyWXD1PmvJFmOrM/SR0rReh6dkNoQiTZjBVyT2L8COcgbSkp+lFWgliJKA6UuGxttUrAlRCya6ldItei7d/5xWaKeHNAi8AY6QtwAEomXWk0Ad/Aj/+HnGe5RuJhSJC+QEI0NJ8sCkQ2KJeHa1dj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39840400004)(346002)(396003)(136003)(366004)(54906003)(83380400001)(38100700002)(8936002)(4326008)(8676002)(38350700002)(2616005)(66574015)(1076003)(186003)(5660300002)(36756003)(2906002)(316002)(66476007)(66556008)(66946007)(6666004)(6506007)(107886003)(110136005)(41300700001)(26005)(6512007)(52116002)(966005)(6486002)(478600001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2QxR1Q4R0ZEQS9QYlJ2SHAyNlpnb0NoSmV6c2x5OEJITm1QRlhMRXRJVWlh?=
 =?utf-8?B?SjlKUCtRdExDNGZKbjdEZlVKWHRMNTNvLy9MSllZenlzek1Vb1IzVzA1SFBn?=
 =?utf-8?B?OEVHQUpvUGp2aVdCN0VGMklHQ08vbW9OU24xMEkyY1lXOURQUHBnaFk3VUJ4?=
 =?utf-8?B?S3hVd1ZqalVobGFIMjIrME1ZT011SnA2Sk1OYzc2WmFnamdPYTNnb241ZThw?=
 =?utf-8?B?R09mcGtNNFN0eWpGaTczWTQzZmNoUURlY1pWc0l5TldWRGZDeU1ZbFpPOGMv?=
 =?utf-8?B?NGJ5WUhwMy82TUpRaFdRK0dWaXNYM3o4S3l3VktUVmFnZUtnUHFlNy83bVRY?=
 =?utf-8?B?TU5FMklDcU5vN0cxdWdqbGNHN0JHdUJwZUJOazFkNlB4T0hNYkZjSkNCK29n?=
 =?utf-8?B?WWJDazl3RU5lbDdzandlNlBzRVBvMFhwUHRZQk1TY3R4M0pmT1NpWTR1MkxX?=
 =?utf-8?B?V20xVGZxbE9IT2RXMnpUOEZwczFCcHZjNExQZDNaMTVob3c4Vjg2S2EvaGFR?=
 =?utf-8?B?enN4ZXB4OW5qSWRPLy9tOVF6Ry9RYXdhaEw5U2JOVGp3NmluZXpSVE5EOEI4?=
 =?utf-8?B?TDJXWG5CLzJuZ09hYlI4VkUxM3VKSXMxaW1ZaG1Pc3pmZ3lacjJBTVNoRWlP?=
 =?utf-8?B?MTAvSnc1dWsxNDRFUUxxL0hZZDh5MnpMU3F0NmJjaUNXd0xBYkVxaWd3OEp4?=
 =?utf-8?B?dmpzTkg0MWtlbkFHY0dNUkprS3BNWFRnOXJCNXZ2NUIreHlINzZoeGltMFA2?=
 =?utf-8?B?Yml4TWRaVk1hdzhhbXR0MjZxL3g1cDNXVHY3YVBQTk9xWGo2U3pmTjdqbWF0?=
 =?utf-8?B?TWJITHNJSHgybnFPN1A1UDRBRExaekFINitmVXp0WFhGdm43eFVBTThIb0Q1?=
 =?utf-8?B?UzlTM3ZORU43QWxURlRQZ3EwTHlrZjRNdlVoR0lIU3d5YmpZU21yWEVhNC9P?=
 =?utf-8?B?ZVpyaFp3dnkzTGxTMDFaMXhtdjgrcGtGTzd5MG9vNHNmUkEyaDVTTytwVWRo?=
 =?utf-8?B?REIya2RGWlJhaFNjbC9rM2xqNmZvY2JhZ3NoM0hCcVV5VzNQQXlBYmNIN2xa?=
 =?utf-8?B?YitqVXIzUWVIWHRxczVhbTRHQ0l5QURadFVZeWo1WDNNY3FRdXZVYTlFbTZH?=
 =?utf-8?B?UkZkc1FESDZSQWZ1SjQvK3JIRG8ybUkwaVR2bmdPMXE3QkEvZWh2eUtyeUVs?=
 =?utf-8?B?VFRDUGl5aWlHcU1CRy83OWcvYklPdVFLSDFBRWM2NWRtNG03a3R0VmhCd3J6?=
 =?utf-8?B?bUE5OUpQZllYMVVLV3JCdEw2ajhiVEcrSFozOUd2VUR0T0diNWY0amtTLzNh?=
 =?utf-8?B?NERwdVcxM3NMNGJlOU81NzlJTXFOS1JveVVTeXAwS3lhenBVbllXMjUyL1Y0?=
 =?utf-8?B?c1FINW4yL0FYNHljY0JpSC9yWHE0ZksvQlJzUXFJaG8rVVZTcW9HZWtGNVBS?=
 =?utf-8?B?TkM4QUY3TC9HblFxZG4ydGxLdHNnMk1lYzZTR1RsRmM0Wnduc0dpUU9oUS9L?=
 =?utf-8?B?MzdLK3RxRmg1amFJWUdyTDdCQ0wrMHdid2d3V0c3RXRUWW1XOUlkMk8wSVdW?=
 =?utf-8?B?bWFKQzhWb1dWd2tkc0RmdGpKYzFTTXRjbjRRU0Zralh5UGhVZkdWd1VUQUtQ?=
 =?utf-8?B?UXR4ZUlpb3VaR0s5QldtbDMrYXYrcUxaUHNWTFNqSzVKZnR0QnBUQTFBcU5W?=
 =?utf-8?B?bG5SWmg1QkRDSTJmak5GRWx3SWYwZnQ4OXFsTUxZYk9EUzloUGk4b1pnQUJE?=
 =?utf-8?B?SjVHM1FQZ25YZGxRcmFWN3k0RmZDU3c4S1ZrRGdDWmgxeWF5ZmxKUlQzOWZi?=
 =?utf-8?B?aURoMC82c0gzWFFaMmsrUDVNeXBQcTd6UEZabXdTMFJ5bEMxSzBqSkpCaXJo?=
 =?utf-8?B?SE9KbmhsWUU3MWZGZ3BpVUtQN055T3dLUENMZUplYmxZazJQK1VlS0dGZ1Ax?=
 =?utf-8?B?L25TdXZzUWVKYXNQZllyWVpNOXI0VnllekFvRVdkaU9ub1NCZjRvd0RUYjJz?=
 =?utf-8?B?bWYvV2VrbkxDamRlK2RHbmhoOTRwWUUwSjYzUjBhN2pZTVZ2VE0vRG5ud0V5?=
 =?utf-8?B?cjBnL3pHZWpiRGNjc3NFeGJoNXZMeDRuZDJiMUtISHlDVk16YzUyM2MyeGZE?=
 =?utf-8?B?d0RlUzAzaDZ0T1lodzhQNVR1UUJmWHZnYzUrcEErdTcySmlTYlk3QzFBckJy?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5075
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
 Documentation/dev-tools/checkpatch.rst |  8 +++++
 scripts/checkpatch.pl                  | 43 ++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

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
index 79e759aac543..77f577535fc3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3140,6 +3140,49 @@ sub process {
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

