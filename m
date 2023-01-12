Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F1D666D82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbjALJJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjALJIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:08:07 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5602354D92;
        Thu, 12 Jan 2023 01:03:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9y/afsb6sE2r2/wtnmBSrzWg1/q4gyqOktJ7m7/tg0RBdcHvq/voUPL57VgzBz36mZmvFYdPK9BBFrSjzwRYXq6gmfPH5/nBm2j1qAc/OUH7zxBJNsHMddbflRzbKeN9IYYY9jrwhvVpZsJrh9gpmbE20+XnZG+3diBLzbpGUZSJ7bwHU+oGdMkkjWZHCO5AiIq5Ba7kyCSEq6jNJ4dYk3Sb+js6RYwWUq0DkxNqraz4snPMpyfVn6n23+G05Yl9KQdVH9LyjCNLTwjO5DensoL/oGK0+zhwNYgEW+Ts7HG1TKAz8f7TkHNPykzDkjfxyKRgjMtaU9d4nLWL14/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DH7WtKxagz9CPz2HPUJ2ialOVjez0pBI+23lAOajIUs=;
 b=HWFYwhJSgx6KsAnSt22nAl1vg8mjG/n1zMba6RrYCThMYZ51I2TWnXLHKiNEFEVj8RxeM5qo5BQDZ2znNoYdoKwTVOBCDFQGbkYKSPKzGSgEUqqSHF+D/267aGtPHjcs2s76FbBr2BqDkqu1/KZbV2bmcjqDnqU0pdCXSzWmMRUbogasrykOlxX8jFnfXbtu41HTZllBrXgmR5sXp4Nxx3UEwWN7AuUAhqRPAv3pgVbnXYrQ4YU1THGv/JWNtXC+QiyXAA91A3LEo0YsPlJDUpsw/7waIyJcRt0cUWK9SFeZK13tU/lLbBTOpI85p5lDGC8CmsR1G/2mAWkw7meg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DH7WtKxagz9CPz2HPUJ2ialOVjez0pBI+23lAOajIUs=;
 b=3YeGRaDyrjozb+aQLxx8dOXRYxoygdOUjpLWmN/wftH5pTaUhFX6GHrkY8UuYp2GofU7C98bzzXYzmzZxPhj/EVJ89SkLY+mrvpy1BpiYCMzFPWkf47ofdO3rbExmhf5EjzQjG2qgNuXzwkyoRDXWFAM0GbTEkjJwAzMWElloeRffCY8UDydJEv+KuQ+jN5VeAfOBkPgRD//uBxn4U3lE0blcC3EX+oDmwYl6SBHUbgwcK0RvcropN+FitYWXpRbrVyc1ipDoXdM7efkRXTiTZZRf+10RaxrtDFzQiJY11cFwt3x4OlHRJC5+9Z1Zw23pfBhdivpZDDcTJjCTqBf3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Thu, 12 Jan
 2023 09:03:12 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::8f8e:a358:3bc6:48d1]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::8f8e:a358:3bc6:48d1%7]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 09:03:12 +0000
Message-ID: <edeee00c-c101-460a-0682-a2fa638b95f4@suse.com>
Date:   Thu, 12 Jan 2023 10:03:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 4/4] selftests: kmod: Add tests for merging same-name
 module load requests
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     mcgrof@kernel.org, david@redhat.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221016123031.3963-1-petr.pavlu@suse.com>
 <20221016123031.3963-5-petr.pavlu@suse.com> <Y01d50Z2DK3f9V+Q@alley>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <Y01d50Z2DK3f9V+Q@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::9) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|AM0PR04MB7044:EE_
X-MS-Office365-Filtering-Correlation-Id: f22dc928-dc40-48e5-acb9-08daf47bd4d5
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Taa9yDNBV//3YAACxvKLs+nhtYHqklPWWa3CsnL8PEkOPQbqPIrlVR7F8r/TCo4wQoKFDQpGxE/kttwDagdXJ5rWMbOgRvUsp1xPgk+VpZEKrr0YlV7Rw/zTPUWyEtZJVIRFSFlSlzoTppKxVo8t8pthLlkYYRY8fJvkgE+hT7z4wn///uh18Nlz6UPhToj+zcShLC/zRU1HgA9ssQCtI6Ulbkzf+EIFHVR77/tdFKzp7n5mEkjLW+Cfqgp050L43M7kPM8Y4vwQ1nKk98CfXvmbm6kxBTvu/eWgvHcrohSI/ENxx3fDVsaBqedCOQYypnUYwaJG//QAsGbZ52qFA6y95xNNsnAgneuhhRgnh4NAxFBzDd0DXGbZ7TI7jSlSkorPX15IX0r2egcBV3gw0ghKg6XSWBzgIfm4mYJxmYtF61KMAHal3eKdKV07tj2mCPNn6JqDFAj3OgkxoV2WwVyuzwIlStNNyHbCIVPJF0H4BH+GtGF/NCK02oDGSviCLH+JLKeQpWAaazgxgblkKYRPVlVNXCj+ktW2ngNzwwDPM48CclcECrNvzy70yFpTgdozhE634nXJiLx0vgXD6zWoxkp1fh/d98+DveumiE0ykAcTTyl5Pp9WIxpCMT/NjEJJO3dyI45Kn+c3cfYOhh+Gfr6kAextvylr69VEo1FRMuEz/mvn9uy2guGWkFu9o97/tPxWGDoq3uB5drzLz0lpGgLdwkoDnqWYI7haEKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199015)(6862004)(8936002)(5660300002)(83380400001)(41300700001)(38100700002)(86362001)(36756003)(2906002)(4001150100001)(44832011)(31696002)(30864003)(478600001)(31686004)(26005)(186003)(6512007)(6506007)(6486002)(8676002)(4326008)(66476007)(66946007)(53546011)(316002)(37006003)(66556008)(2616005)(6636002)(55236004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zno5ZDhoZGxrcGNuZFMvOG9XQUxpWUt3SHBBUDg0S1B1L3ZDYUxRRnhSS01O?=
 =?utf-8?B?U3BjNElpVklMN1lra3ZDZHJSM1Flb3F3RFlwc0FSL1VXM1ZpellXd2FCbVo3?=
 =?utf-8?B?eTdxb0NpU1lUUGY2bUhFbUxTYXdhUFQ5RDEyUTVjYlRRMEg3VFlOcyszM0R3?=
 =?utf-8?B?LzF1Z05Mblp5bFdZUnFRK1FjejFENERLdTZOUEdRUEppb2M0UjJkSDJvaXVm?=
 =?utf-8?B?dVhLSGdPcC9kK1owUUV1aFJYaHI4ZGpSRUlPempXY2RnbVYveldmaVdFQlN3?=
 =?utf-8?B?K25RbjRCWEl5Y3JWb3FCbE4wbXhkeGUzUzBha1M3UGhSaGk0NUZSTUtWNGpq?=
 =?utf-8?B?MVUwNXB2TGRSMHN5dnoxT20va0RRdW5Gamtma0NKV3BmNGdzY1UxS1NrQVFS?=
 =?utf-8?B?emNqTFpuN1dMWlZwNFpDQklFSUNJYUxBWDFlWEZrT0gvaHo1WFM4UkM2Vmt1?=
 =?utf-8?B?b0FWb2RvU2NBbVpycUtEeEpRTmw4cWhyRG9VdlN1RDFIOTN1WUZzdEphQVNi?=
 =?utf-8?B?K2V5eTF1dS83amx0WCtkS1JyUmQrQmUvYU1PRkJwZHJORUtoOUpJQzRHc0g4?=
 =?utf-8?B?UzlhYlkxYVVXOHlYcm1KVFJLTW1SUnFIV0JXMEJraXk4aUg2V0wvbEE3MER4?=
 =?utf-8?B?RlZMb3pzUjg2OHNCekpwVlFNcERNRmdCZXRVaUNNdXhqeVJNVS8vbE5QWlQy?=
 =?utf-8?B?MCs2Z1lHeUN1Qk5pMzROU0ZjenorSkU3c3NBaG5jQnVYN0xEa0tDbHFNNHhK?=
 =?utf-8?B?bVBWZ3JPcHpXa1UyTStGUEcvRUhybFlrTTFXSHl5Q3I2M0szcU52eXFod21r?=
 =?utf-8?B?YUVIdWZTMmM5STljOHJFb2JEU21vN3l0M0tSbWZaU3l0eUhBeEdBeGFOY0Fh?=
 =?utf-8?B?enpFRTN4Vzh0V1R3czJFbHhzZStRYS95blVhVmlyRjQ1L3Qzc1RHdzBzYzVz?=
 =?utf-8?B?TTBWZldwalY2OEtFZzJCQVRoNzM5N25VYWc2eVl1cW9TU3FSNWxwc2FKbWQ1?=
 =?utf-8?B?dlo3OEpZNHNNR1VsdEtwdTA4NjJtUWVYMkxlNGcweHgvKzlrcUhGd29DL1Ft?=
 =?utf-8?B?aThieGovRUtRM0c2LzBUQk1jWTcwUGpCSVptRzBmSGF2VGU0d0dkdDMwZzRY?=
 =?utf-8?B?V1g5NVRHS042cDh6N05rRm83ZkdGb2pXVnJuZDN5R2RBRFNtUVBTY3JUTFJQ?=
 =?utf-8?B?UVNLZTVqekpwdVB5TTVueG85Q3BYcTN1SWF0NTUvOHNZUVM4YkxyUVlCWW9P?=
 =?utf-8?B?UHV3UTNHc2hJQm0zY2NzMU1HZU8zcGxJejZ1RHdVVzRhdU45U1NHV2lqem56?=
 =?utf-8?B?UUdCeGM5d0tFOFJmbXpMSzJodmlHZE1OLzNzQmZNNmY4aGxzR21hQXk4c3FD?=
 =?utf-8?B?ak1QTHdWY1c4ZFltVGlFeGw3UFFYeDN5eklsbjNuc2lESExSM1I3MFNYUCtm?=
 =?utf-8?B?K1ovOGxFc0F0bXcxR1JJQ291dEFZSFlvL3RZNkUrN1BIc2k2MnZrdUlLUE9s?=
 =?utf-8?B?ZUJyeUpNQUlRbWxMbzBPUXhuOWE0V3pOT29HWW5jN0J2eVozbkNpOFd4eUp4?=
 =?utf-8?B?Tk9qWXNNRUZmaXF2ZncyajY0TUdJQlc0UG14cGgwajNpZFQrb0pjOUZXbUpT?=
 =?utf-8?B?OHhhNVQ3MmhqejFGM3VKV2xIRDRSblNCNXdpTWZqVFVlK21HOWZIbHRPWG9P?=
 =?utf-8?B?SlRmNlRIMEdzKzBBY2lETll0SmpKYVJKNGcvWkU3Y3dPeDJma1M5QmRFa2x0?=
 =?utf-8?B?Q29laEd3QktGd3AyL2ZpV1FSa1lUQmxyOCtaaDRxb1hVaG5PWjRKOG1ZRk5h?=
 =?utf-8?B?K1RiaUVjQnRiVHM1Vmd3MWo4K1FqK1pkSm9xYkMybkNuT3BYcWQxdEtwbU11?=
 =?utf-8?B?UDRobmpoODNralZiMW5LQ29EZ05YQkNnVU9CREtuNUlyVjdGY0VrSTRHWm9a?=
 =?utf-8?B?TzAvaE5tWS8vckM4bkttZWRZRnI3a2RoU3lNa0ovN0kvZTlqdGREb1hMMysv?=
 =?utf-8?B?S3pYb2s4YW83UFpDQ3JkL20xdm9hUHFqU1pJZktFUzhSc2l0Ym1JaW9XYkJD?=
 =?utf-8?B?YWxNT1RYRWhNZEJKbGtScndsSjRRN01kVkczUkk1dkRJS1NsTU5FSDc2NW42?=
 =?utf-8?Q?ioOTAiys2DU1FRLEkdT65f0lD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22dc928-dc40-48e5-acb9-08daf47bd4d5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 09:03:11.7149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUEv+H0d+acQJ25FvC5/ijZGHW6n2itfHNLmFfUDLUKwQLPcMcabS+yKDhdVCxaII/0wCHYP40wKLsXcVdUEiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[A different fix that the one from this thread was selected but it is still
useful to discuss these test cases and if they should be added in some form.]

On 10/17/22 15:51, Petr Mladek wrote:
> On Sun 2022-10-16 14:30:31, Petr Pavlu wrote:
>> Add two tests to check that loading the same module multiple times in
>> parallel results only in one real attempt to initialize it.
>> Synchronization of the loads is done by waiting 1000 ms in the init
> 
> I do not have a good experience with this kind of synchronization.
> It usually is not reliable. The test might be very slow especially when
> false positives are solved by prolonging the delay.
> 
> Alternative solution would be to have two modules:
> 
> 1st module would provide a counter, for example:
> 
> int modB_load_cnt;
> module_param(modB_load_cnt, int, 0444);
> EXPORT_SYMBOL(modB_load_cnt);
> 
> EXPORT_SYMBOL() should allow to directly increment the counter
> from the 2nd module.
> 
> module_param() should make the value readable via
> /sys/module/modA/parameters/modB_load_cnt. It can be
> checked by kmod_sh.

I agree that it would be best to avoid any synchronization based on timeouts
in these tests.

My reading is that your idea should allow the tests to remove measuring how
long it took in total to process all module inserts. It was possible for me to
implement this change.

It unfortunately doesn't help with the 1 second timeout that the
kmod_test_0014 module (modB in your description) has in its init function. Its
purpose is to make sure that any parallel loads of the same module which were
started by kmod.sh manage to reach add_unformed_module(), sleep there and
therefore hit the updated logic.

One option how to avoid this timeout is to extend modA to register a kprobe on
finished_loading() and export via a parameter which loads started by kmod.sh
reached this point. This approach works ok on my system and a prototype is
pasted at the end of this mail. Two shortcomings are that it relies on
internal knowledge of the module loader code and function finished_loading()
might not be always available for probing as it could get inlined in some
configurations.

To summarize, I see the following options for these tests:
* Use a timeout to synchronize the loads.
* Use the outlined kprobe approach.
* Don't add these tests at all.

Any opinions what would be preferred? I'm leaning towards not adding these
tests as they look fragile to me.

Thanks,
Petr

---

diff --git a/tools/testing/selftests/kmod/.gitignore b/tools/testing/selftests/kmod/.gitignore
new file mode 100644
index 000000000000..ea3afcaccc79
--- /dev/null
+++ b/tools/testing/selftests/kmod/.gitignore
@@ -0,0 +1 @@
+init_module
diff --git a/tools/testing/selftests/kmod/Makefile b/tools/testing/selftests/kmod/Makefile
index 5b3e746a0bee..1c684ac700b5 100644
--- a/tools/testing/selftests/kmod/Makefile
+++ b/tools/testing/selftests/kmod/Makefile
@@ -1,12 +1,20 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Makefile for kmod loading selftests
 
-# No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
-all:
-
 TEST_PROGS := kmod.sh
 
+# compile but not part of 'make run_tests'
+TEST_GEN_PROGS_EXTENDED := \
+	init_module test_kmod_parallel_count.ko test_kmod_parallel_sleep.ko
+
+# override lib.mk's default rule
+override define CLEAN
+	$(RM) $(TEST_GEN_PROGS_EXTENDED)
+	$(MAKE) -C test_kmod_parallel clean
+endef
+
 include ../lib.mk
 
-# Nothing to clean up.
-clean:
+$(OUTPUT)/test_kmod_parallel_count.ko $(OUTPUT)/test_kmod_parallel_sleep.ko: $(wildcard test_kmod_parallel/Makefile test_kmod_parallel/*.[ch])
+	$(MAKE) -C test_kmod_parallel
+	cp test_kmod_parallel/$(notdir $@) $@
diff --git a/tools/testing/selftests/kmod/config b/tools/testing/selftests/kmod/config
index 259f4fd6b5e2..704c4735686c 100644
--- a/tools/testing/selftests/kmod/config
+++ b/tools/testing/selftests/kmod/config
@@ -5,3 +5,7 @@ CONFIG_XFS_FS=m
 # For the module parameter force_init_test is used
 CONFIG_TUN=m
 CONFIG_BTRFS_FS=m
+
+# For the module test_kmod_parallel
+CONFIG_KALLSYMS=y
+CONFIG_KPROBES=y
diff --git a/tools/testing/selftests/kmod/init_module.c b/tools/testing/selftests/kmod/init_module.c
new file mode 100644
index 000000000000..529abd0a8357
--- /dev/null
+++ b/tools/testing/selftests/kmod/init_module.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Simple program to insert a module, similar to insmod but tailored
+ * specifically for needs of module loader tests.
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <errno.h>
+
+int main(int argc, char *argv[])
+{
+	const char *filename, *args;
+	int fd, ret;
+
+	if (argc < 2 || argc > 3) {
+		fprintf(stderr, "usage: %s filename [args]\n", argv[0]);
+		return EINVAL;
+	}
+
+	filename = argv[1];
+	args = argc > 2 ? argv[2] : "";
+
+	fd = open(filename, O_RDONLY);
+	if (fd == -1) {
+		ret = errno;
+		fprintf(stderr, "init_module: could not open file %s: %s\n",
+			filename, strerror(ret));
+		return ret;
+	}
+
+	ret = syscall(SYS_finit_module, fd, args, 0);
+	if (ret != 0) {
+		ret = errno;
+		fprintf(stderr, "init_module: could not load module %s: %s\n",
+			filename, strerror(ret));
+	}
+
+	close(fd);
+
+	return ret;
+}
diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index afd42387e8b2..8ca82b16f165 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -65,6 +65,8 @@ ALL_TESTS="$ALL_TESTS 0010:1:1"
 ALL_TESTS="$ALL_TESTS 0011:1:1"
 ALL_TESTS="$ALL_TESTS 0012:1:1"
 ALL_TESTS="$ALL_TESTS 0013:1:1"
+ALL_TESTS="$ALL_TESTS 0014:1:1"
+ALL_TESTS="$ALL_TESTS 0015:1:1"
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
@@ -171,6 +173,12 @@ errno_name_to_val()
 		echo -1;;
 	-ENOENT)
 		echo -2;;
+	-EBUSY)
+		echo -16;;
+	-EEXIST)
+		echo -17;;
+	-ENODEV)
+		echo -19;;
 	-EINVAL)
 		echo -22;;
 	-ERR_ANY)
@@ -190,6 +198,12 @@ errno_val_to_name()
 		echo -EPERM;;
 	-2)
 		echo -ENOENT;;
+	-16)
+		echo -EBUSY;;
+	-17)
+		echo -EEXIST;;
+	-19)
+		echo -ENODEV;;
 	-22)
 		echo -EINVAL;;
 	-123456)
@@ -504,6 +518,135 @@ kmod_test_0013()
 		"cat /sys/module/${DEFAULT_KMOD_DRIVER}/sections/.*text | head -n1"
 }
 
+# Check that loading the same module multiple times in parallel results only in
+# one real attempt to initialize it. The function utilizes two sample modules
+# test_kmod_parallel_count and test_kmod_parallel_sleep:
+# TODO Describe.
+#
+# Cases:
+# * Test 0014 checks a situation when the load is successful. It should result
+#   in one insert returning 0 and remaining inserts returning EEXIST.
+# * Test 0015 checks a situation when the load is failing because the module
+#   init function returns ENODEV. It should result in one insert returning this
+#   error code and remaining inserts returning EBUSY.
+kmod_check_parallel_loads()
+{
+	local test_name="$1"
+	local parallel_loads="$2"
+	local insmod_params="$3"
+	local success_exp="$4"
+	local ebusy_exp="$5"
+	local eexist_exp="$6"
+	local enodev_exp="$7"
+	local other_exp="$8"
+
+	local EBUSY=$(errno_name_to_val -EBUSY)
+	local EEXIST=$(errno_name_to_val -EEXIST)
+	local ENODEV=$(errno_name_to_val -ENODEV)
+	local init_cnt pids hits rc
+	local success_cnt=0 ebusy_cnt=0 eexist_cnt=0 enodev_cnt=0 other_cnt=0
+	local test_ok=true
+
+	# Load the counter module
+	./init_module test_kmod_parallel_count.ko
+
+	# Run the parallel loads.
+	for i in $(seq 0 $(($parallel_loads - 1))); do
+		(echo $BASHPID > /sys/module/test_kmod_parallel_count/parameters/pids_watched;
+		 exec ./init_module test_kmod_parallel_sleep.ko "$insmod_params") &
+		pids[$i]=$!
+	done
+
+	# Wait for all secondary loads to block in add_unformed_module().
+	while true; do
+		hits=( $(cat /sys/module/test_kmod_parallel_count/parameters/pids_hit) )
+		(( ${#hits[@]} >= $parallel_loads - 1 )) && break
+		sleep 0.1
+	done
+	echo > /sys/module/test_kmod_parallel_count/parameters/pids_watched
+
+	# Set the state to 1 which unblocks the init function.
+	echo 1 > /sys/module/test_kmod_parallel_count/parameters/state
+
+	# Collect all results.
+	for pid in ${pids[*]}; do
+		{ wait $pid; let rc=-$?; } || true
+
+		case $rc in
+		0)
+			let success_cnt=$success_cnt+1;;
+		$EBUSY)
+			let ebusy_cnt=$ebusy_cnt+1;;
+		$EEXIST)
+			let eexist_cnt=$eexist_cnt+1;;
+		$ENODEV)
+			let enodev_cnt=$enodev_cnt+1;;
+		*)
+			let other_cnt=$other_cnt+1;;
+		esac
+	done
+
+	if (( $success_cnt > 0 )); then
+		rmmod test_kmod_parallel_sleep
+	fi
+
+	init_cnt=$(cat /sys/module/test_kmod_parallel_count/parameters/init_count)
+	rmmod test_kmod_parallel_count
+
+	# Check the results.
+	if (( $init_cnt != 1 )); then
+		echo "$test_name: FAIL, number of init calls, test expects '1' - got '$init_cnt'" >&2
+		test_ok=false
+	else
+		echo "$test_name: OK! - number of init calls, test expects '1' - got '$init_cnt'" >&2
+	fi
+	if (( $success_cnt != $success_exp )); then
+		echo "$test_name: FAIL, number of successful loads, test expects '$success_exp' - got '$success_cnt'" >&2
+		test_ok=false
+	else
+		echo "$test_name: OK! - number of successful loads, test expects '$success_exp' - got '$success_cnt'" >&2
+	fi
+	if (( $ebusy_cnt != $ebusy_exp )); then
+		echo "$test_name: FAIL, number of loads returning EBUSY, test expects '$ebusy_exp' - got '$ebusy_cnt'" >&2
+		test_ok=false
+	else
+		echo "$test_name: OK! - number of loads returning EBUSY, test expects '$ebusy_exp' - got '$ebusy_cnt'" >&2
+	fi
+	if (( $eexist_cnt != $eexist_exp )); then
+		echo "$test_name: FAIL, number of loads returning EEXIST, test expects '$eexist_exp' - got '$eexist_cnt'" >&2
+		test_ok=false
+	else
+		echo "$test_name: OK! - number of loads returning EEXIST, test expects '$eexist_exp' - got '$eexist_cnt'" >&2
+	fi
+	if (( $enodev_cnt != $enodev_exp )); then
+		echo "$test_name: FAIL, number of loads returning ENODEV, test expects '$enodev_exp' - got '$enodev_cnt'" >&2
+		test_ok=false
+	else
+		echo "$test_name: OK! - number of loads returning ENODEV, test expects '$enodev_exp' - got '$enodev_cnt'" >&2
+	fi
+	if (( $other_cnt != $other_exp )); then
+		echo "$test_name: FAIL, number of loads returning other values, test expects '$other_exp' - got '$other_cnt'" >&2
+		test_ok=false
+	else
+		echo "$test_name: OK! - number of loads returning other values, test expects '$other_exp' - got '$other_cnt'" >&2
+	fi
+
+	[ $test_ok = true ] || exit 1
+}
+
+kmod_test_0014()
+{
+	kmod_check_parallel_loads \
+		"${FUNCNAME[0]}" 4 "sleep_msecs=1000 init_retval=0" 1 0 3 0 0
+}
+
+kmod_test_0015()
+{
+	local ENODEV=$(errno_name_to_val -ENODEV)
+	kmod_check_parallel_loads \
+		"${FUNCNAME[0]}" 4 "sleep_msecs=1000 init_retval=$ENODEV" 0 3 0 1 0
+}
+
 list_tests()
 {
 	echo "Test ID list:"
@@ -525,6 +668,8 @@ list_tests()
 	echo "0011 x $(get_test_count 0011) - test completely disabling module autoloading"
 	echo "0012 x $(get_test_count 0012) - test /proc/modules address visibility under CAP_SYSLOG"
 	echo "0013 x $(get_test_count 0013) - test /sys/module/*/sections/* visibility under CAP_SYSLOG"
+	echo "0014 x $(get_test_count 0014) - test handling of parallel loads, success case"
+	echo "0015 x $(get_test_count 0015) - test handling of parallel loads, init returning error"
 }
 
 usage()
diff --git a/tools/testing/selftests/kmod/settings b/tools/testing/selftests/kmod/settings
new file mode 100644
index 000000000000..ba4d85f74cd6
--- /dev/null
+++ b/tools/testing/selftests/kmod/settings
@@ -0,0 +1 @@
+timeout=90
diff --git a/tools/testing/selftests/kmod/test_kmod_parallel/Makefile b/tools/testing/selftests/kmod/test_kmod_parallel/Makefile
new file mode 100644
index 000000000000..8d2b24aa868f
--- /dev/null
+++ b/tools/testing/selftests/kmod/test_kmod_parallel/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+KMOD_TEST_PARALLEL_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= $(abspath $(KMOD_TEST_PARALLEL_DIR)/../../../../..)
+
+obj-m := test_kmod_parallel_count.o test_kmod_parallel_sleep.o
+
+all:
+	$(MAKE) -C $(KDIR) M=$(KMOD_TEST_PARALLEL_DIR) modules
+
+clean:
+	$(MAKE) -C $(KDIR) M=$(KMOD_TEST_PARALLEL_DIR) clean
diff --git a/tools/testing/selftests/kmod/test_kmod_parallel/test_kmod_parallel_count.c b/tools/testing/selftests/kmod/test_kmod_parallel/test_kmod_parallel_count.c
new file mode 100644
index 000000000000..8de9351d6df9
--- /dev/null
+++ b/tools/testing/selftests/kmod/test_kmod_parallel/test_kmod_parallel_count.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/kprobes.h>
+#include <linux/kstrtox.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/string.h>
+#include <linux/wait.h>
+
+/*
+ * State parameter: value 0 blocks the init function of test_kmod_parallel_sleep
+ * when it invokes test_kmod_parallel_count_wait(), value 1 makes it to proceed.
+ */
+static unsigned int state;
+static DECLARE_WAIT_QUEUE_HEAD(state_wq);
+
+static int state_set(const char *val, const struct kernel_param *kp)
+{
+	int err;
+
+	err = kstrtoint(val, 0, &state);
+	if (err != 0)
+		return err;
+
+	wake_up_interruptible(&state_wq);
+	return 0;
+}
+
+static const struct kernel_param_ops state_ops = {
+	.set = state_set,
+	.get = param_get_uint,
+};
+
+module_param_cb(state, &state_ops, &state, 0644);
+MODULE_PARM_DESC(state, "module state switch, default 0");
+
+/*
+ * Counter to record how many times the init function of
+ * test_kmod_parallel_sleep was invoked.
+ */
+static unsigned int init_count;
+module_param(init_count, uint, 0444);
+MODULE_PARM_DESC(init_count, "counter for test_kmod_parallel_sleep_init()");
+
+int test_kmod_parallel_count_wait(void)
+{
+	kernel_param_lock(THIS_MODULE);
+	init_count++;
+	kernel_param_unlock(THIS_MODULE);
+
+	/* Wait for an external actor to transfer the state from 0 to 1. */
+	return wait_event_interruptible(state_wq, state == 1);
+}
+EXPORT_SYMBOL(test_kmod_parallel_count_wait);
+
+/*
+ * Tasks watched for invocation of finished_loading() and which ones actually
+ * executed the function.
+ */
+static DEFINE_SPINLOCK(pids_lock);
+static pid_t pids_watched[4] = { -1, -1, -1, -1 };
+static pid_t pids_hit[4] = { -1, -1, -1, -1 };
+
+static int format_pids(char *buffer, const pid_t *pids, size_t pids_size)
+{
+	int ret = 0;
+	size_t i;
+
+	for (i = 0; i < pids_size; i++) {
+		if (pids[i] == -1)
+			break;
+		ret += sprintf(buffer + ret, "%s%d", ret != 0 ? " " : "",
+			       pids[i]);
+	}
+
+	ret += sprintf(buffer + ret, "\n");
+	return ret;
+}
+
+static int pids_watched_set(const char *val, const struct kernel_param *kp)
+{
+	int err;
+	size_t i;
+	pid_t pid;
+
+	spin_lock(&pids_lock);
+
+	/* Handle the reset case. */
+	if (sysfs_streq(val, "")) {
+		for (i = 0; i < ARRAY_SIZE(pids_watched); i++) {
+			pids_watched[i] = -1;
+			pids_hit[i] = -1;
+		}
+		goto success;
+	}
+
+	/* Add one PID to the watch set. */
+	err = kstrtoint(val, 0, &pid);
+	if (err != 0)
+		goto err;
+	if (pid < 0) {
+		err = -EINVAL;
+		goto err;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pids_watched); i++)
+		if (pids_watched[i] == -1) {
+			pids_watched[i] = pid;
+			break;
+		}
+
+	if (i == ARRAY_SIZE(pids_watched)) {
+		err = -EINVAL;
+		goto err;
+	}
+
+success:
+	err = 0;
+err:
+	spin_unlock(&pids_lock);
+	return err;
+}
+
+static int pids_watched_get(char *buffer, const struct kernel_param *kp)
+{
+	int ret;
+
+	spin_lock(&pids_lock);
+	ret = format_pids(buffer, pids_watched, ARRAY_SIZE(pids_watched));
+	spin_unlock(&pids_lock);
+
+	return ret;
+}
+
+static const struct kernel_param_ops pids_watched_ops = {
+	.set = pids_watched_set,
+	.get = pids_watched_get,
+};
+
+module_param_cb(pids_watched, &pids_watched_ops, NULL, 0644);
+MODULE_PARM_DESC(state, "PIDs watched for finished_loading()");
+
+static int pids_hit_get(char *buffer, const struct kernel_param *kp)
+{
+	int ret;
+
+	spin_lock(&pids_lock);
+	ret = format_pids(buffer, pids_hit, ARRAY_SIZE(pids_hit));
+	spin_unlock(&pids_lock);
+
+	return ret;
+}
+
+static const struct kernel_param_ops pids_hit_ops = {
+	.get = pids_hit_get,
+};
+
+module_param_cb(pids_hit, &pids_hit_ops, NULL, 0444);
+MODULE_PARM_DESC(state, "PIDs which hit finished_loading()");
+
+static int __kprobes finished_loading_pre(struct kprobe *p,
+					  struct pt_regs *regs)
+{
+	size_t i;
+
+	spin_lock(&pids_lock);
+
+	/* Check if this task is watched. */
+	for (i = 0; i < ARRAY_SIZE(pids_watched); i++)
+		if (current->pid == pids_watched[i])
+			break;
+	if (i == ARRAY_SIZE(pids_watched))
+		goto out;
+
+	/* Record the hit. */
+	for (i = 0; i < ARRAY_SIZE(pids_hit); i++) {
+		if (current->pid == pids_hit[i])
+			break;
+		if (pids_hit[i] != -1)
+			continue;
+		pids_hit[i] = current->pid;
+		break;
+	}
+
+out:
+	spin_unlock(&pids_lock);
+	return 0;
+}
+
+static struct kprobe finished_loading_kp = {
+	.symbol_name = "finished_loading",
+	.pre_handler = finished_loading_pre,
+};
+
+static int __init test_kmod_parallel_count_init(void)
+{
+	int err;
+
+	err = register_kprobe(&finished_loading_kp);
+	if (err < 0) {
+		pr_err("register_kprobe failed, returned %d\n", err);
+		return err;
+	}
+	return 0;
+}
+
+static void __exit test_kmod_parallel_count_exit(void)
+{
+	unregister_kprobe(&finished_loading_kp);
+}
+
+module_init(test_kmod_parallel_count_init);
+module_exit(test_kmod_parallel_count_exit);
+
+MODULE_AUTHOR("Petr Pavlu <petr.pavlu@suse.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_INFO(test, "Y");
diff --git a/tools/testing/selftests/kmod/test_kmod_parallel/test_kmod_parallel_sleep.c b/tools/testing/selftests/kmod/test_kmod_parallel/test_kmod_parallel_sleep.c
new file mode 100644
index 000000000000..cd1b8184af2a
--- /dev/null
+++ b/tools/testing/selftests/kmod/test_kmod_parallel/test_kmod_parallel_sleep.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+int test_kmod_parallel_count_wait(void);
+
+static int init_retval;
+module_param(init_retval, int, 0644);
+MODULE_PARM_DESC(init_retval, "init return value, default 0");
+
+static int __init test_kmod_parallel_sleep_init(void)
+{
+	int err;
+
+	err = test_kmod_parallel_count_wait();
+	if (err != 0)
+		return err;
+
+	return init_retval;
+}
+
+static void __exit test_kmod_parallel_sleep_exit(void)
+{
+}
+
+module_init(test_kmod_parallel_sleep_init);
+module_exit(test_kmod_parallel_sleep_exit);
+
+MODULE_AUTHOR("Petr Pavlu <petr.pavlu@suse.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_INFO(test, "Y");
