Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1FB70C232
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjEVPUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbjEVPTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:19:54 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2135.outbound.protection.outlook.com [40.107.241.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF16129;
        Mon, 22 May 2023 08:19:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MP712sBG5rizobeczqBBpqMR3xA2PpacdBNekJ4/jJoz3QbWRSpCKPdsqNQNDGG8+ksjweMwFz5OD5kGffdNEWTnRWlLFw0E49vG2RBv2tr9KlCvD6SjzhQpKrGdtjGK5IfnDaQ1NazHuFv16x180ITW9vQGGvkl8SH45awUjjIIPAeAOOmcm2jFIV5AaXwlErJmeImpRJ5XEKa1Rpx0SRSMR6z8LIEEB1LpOcUZx8FguQK8wkhB3l/yqk6h2NMJtm8vMQom/SRbHVv2zMZX/wnluEO5WBEh3yXgIH3avp9RwSItd+c983CT0g7Kag/hLdalFvHkr75aACT9FyBOGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NuSyqxhS8LZeSxKn5FCqVopNtGRTQkhIE1DldOXLnQ=;
 b=cE8PWU7YMeB4QxWiOxgj3e4Hz2KpB08LxJoNN0h+Jtg1PTlgMcHv4iTFO818q8IVNDhmmfNsYNcev/JvBjiZ7ch+YLX2ExwZuRi2j27sNgLWKc5s7jB+tCno79Nc1ir8iQ5PekZMtA859+wfcl2BXV/rSspRicTyGJqXQVicPn7qK9snmKaAH5Fqa7b38RSFkP2jjXNLN1JZWBPLxWcbezhDdPX9KW3t0IvRR/R5JUTJGS8yQ+DgB4m9JFZH1Yt6bTIgJ6qk3HoKdmT38Pfp84J6DBUeRTXXR06d6aR8RK2Mhf2iASr5OKxZ2yC1J4YadYIYWH184jg24Y8fNryIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NuSyqxhS8LZeSxKn5FCqVopNtGRTQkhIE1DldOXLnQ=;
 b=fYPZ1TwOI91va2tK7MhYFifS09ZIuxWCgcUzBZ+TibHR63XAEROD2/X3Ab2EMIhINm5/GnYpWZINMAWHdkOL1ZcsUglXHk+zBi+iQnPwIfq2q4cQfJpJKtgxFRgEYfG00lJEHxEjKlX4bWWELoGEzwRnjTdnDBOa2uQ4x1BejYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AS8PR02MB9386.eurprd02.prod.outlook.com (2603:10a6:20b:5a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 15:19:46 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 15:19:46 +0000
Message-ID: <7e2cfb55-e39f-2e5c-7f43-e1d275428bb5@axentia.se>
Date:   Mon, 22 May 2023 17:19:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: sv-SE, en-US
To:     LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
From:   Peter Rosin <peda@axentia.se>
Subject: PWM regression causing failures with the pwm-atmel driver
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::15) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|AS8PR02MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0b4f93-3c72-4eff-98b5-08db5ad7fa22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqfmDVEJLxbtAYsLRU+IIDAz7U+OrmZiwCgDgnJ/eEiFC48K+z3B/aBSRwZyjT/1ewajHU76qkfVMFcibbjWqb7lU3hpuxYUta51wNBGQp8ce+jiRTN6wD+X2deF0Kx4mDA0S++30s+jHsIDxirssbXjcHhkUfZRlPOSypY6DokfjnxmHQw0oApyL/8L81YwU6Z1Pzvd5Rn/8decjvnkcraxld1R6B3jBavxKhLzjkPUTyhEG3Noruzx8A6XbyqKpBICbIJ1QdmJ5zGoU1g6wwWxInoVcOueKTHVq+2yigVfmSB0zFMFz7LeSx6Um3RQBeMmubWzuS+ZStp9lYdn7WUtYvmWlv4rcjYsXna0IYoA6UKTbjp7QkgLnGJ8P39ybY1gcJ7VHZCisCOpbW5rYzEy52dTlYxd5xUI/jZy67tYP0q02ZJ84efJ+Htv2+gvd5DRl7NCwOsiSllUZsjK7JaT7tNKg4anGCJiUzZLUnvGRV4Cc/zSlGGUFZVWeXTvwJvCE2rbPi5oq45SjbaK2netHbufF887fHmVln6sWpu3CbA/YyQl9d2y9iJm/3M6zR1BGnPD4pdrOeUgDdHt2dRBNvi5qpAV0iMEufVS7dwNQK0cc0/Eh6lrx2tdQ9tLi36a5a3NBD0ynWvce4MBhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(39840400004)(396003)(451199021)(5660300002)(8936002)(8676002)(83380400001)(36756003)(186003)(2616005)(38100700002)(2906002)(31696002)(86362001)(6506007)(26005)(6512007)(6666004)(316002)(4326008)(66556008)(66476007)(66946007)(478600001)(110136005)(41300700001)(54906003)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anljanR6MW5nY1VVeXovejR2Q1MxelpIcEsrUE1mQ1Zuc2RQczlZQjRGRlpm?=
 =?utf-8?B?aUwzaVByU28yT2Y1Q2lxcVNCeUFaUnZoUWFWTzJSNXVJTmtWTnE4RmZzT0Rr?=
 =?utf-8?B?d0VtT3p0eVVVNTVwZnJHdUxKemg5ZXlmRytVV0ZrV1A5OGNlTkx3YjVGYk1v?=
 =?utf-8?B?Qlhld1RYR0U1Kzh1OU85WG55S2xGS3lMeVpPWEVJL0Rjby9TOFI3QW83VTNT?=
 =?utf-8?B?QVhtRGFPTUF3MVNxN0hBNGVjdlIwOEJLUUNVc1I2eCtyQ2FNV0dneW11UVV2?=
 =?utf-8?B?VVlnNi9vODgrQUMvckx5T1ZJcU5TUk1EL1djaFhzOTZYNVNxMVU2YnJnS3hB?=
 =?utf-8?B?UEh0eFF1MVNBdG9GSjlZb0NENUdGSy9RMjMrVjM3YVd2UzZpYmRoQmNFSjlQ?=
 =?utf-8?B?dmdCbzJKRTJHeUpXZWxxd2t2MGhaMnl4RGpMc1V6amN6OHFraWFueitEdFEx?=
 =?utf-8?B?aEZqUEJsZ2xidmV5dEl6VnlYYmhQWG9DbTU4TUtZVnpBbDRLY3hIMDR2NEpK?=
 =?utf-8?B?MnFwRTVQTEE2b1FMRHFlT29FNXdvNnlLTnRBbUtZWHN5VjNxaForMm1lQnEw?=
 =?utf-8?B?aFZKUkN3QVF1Z3hZUXBTZHljd2g4Zi83cHRqa1MxVG9sUE96bjNrMHNnOENI?=
 =?utf-8?B?bWlkajJobFpHemNWc2hMOGcydnNOWnFCak0vMlBBVE1nWXh6OU8yYjlPdFhL?=
 =?utf-8?B?ZGRGdk5oYmpTVXh5TjYwcGlhM1FmeHloTzk4SEJlRXVUNlQ4MjR1OXpVM05u?=
 =?utf-8?B?SUtncmIySG90RzFXWlY4OU9xLzdtdGljeUlrakFWelhYRFNYSXFYQTEyMU5O?=
 =?utf-8?B?KzM5SzlGL1ZlT0YzeGpPT280R0Ewd1E2eHN0NXZab1lpWjNZWExMZmJKVnFE?=
 =?utf-8?B?R2RaWkJFV0ZoNWZEZUZFQUxlL0NUVDBSVlk2RHRSUk9ZbXpPTUc5dDZVeGwz?=
 =?utf-8?B?dEJsN3NaOTJUdHlDeXl2MUJMSlNvQzQva25oa3U4RG9EclBIZ3BCdit1R2xl?=
 =?utf-8?B?TzlzcUk5bTh1eWFXWlcwY05tajFrUXJja1RsaSttTi9jb2Nwd2tXcEI3M2M4?=
 =?utf-8?B?dVcvOWlrOFRYSnR2dEMxUFdmR2pjSHdTd081Tk9mb0FTOWhSUXhUQU9FNzBq?=
 =?utf-8?B?U3luaFhyc1FpbHdOUlVBRkg5Q1RRS3hXV2N0WXFOaE1UalEwOGFlVlltNnBj?=
 =?utf-8?B?N2JSa1FycThVbTJnN2NWUlhhcTAzVVRDM1gxWWM1emYzUk83MWdiVGpoQzlq?=
 =?utf-8?B?U2FyVUdBTWpaUkM4TmtiMkdad2Vpa1gySkJzMWFHVmN5TkxzMVIyWStoREJH?=
 =?utf-8?B?Vk5MNUQ2ZnErTGRJUXdMbWZDRHBONUgvQTh1UFB1NWNvbFZZUW85cnhOdWEy?=
 =?utf-8?B?Wm1ueHJ5RTZubHRITmZYaXVDb2EzNlN6STlGWUJUUFh4MXhqSEVSVGw5MEFK?=
 =?utf-8?B?clJGaGV1OU92RkVVU0FKb1VvTEhwaFUxYUwzK2xnUW4vVnYwSEZyK0N3dXJU?=
 =?utf-8?B?LzJ1N0VKOWtNZFhEczNNYXRROHNucTBrb2Z4dVN3MitlT1ljSHNXeGpkVE95?=
 =?utf-8?B?bTJqMFNxbUsyMTBxK0IvZUFGbUQ4RnNlc0ZlbnpnTVpmdStJRVA0anRsdnZM?=
 =?utf-8?B?WU5yTlB3Y2tDemtVS0xjSGYzY0lZNFMzaS8rZjVWM1pKY0hNT3lQeUVnUDZl?=
 =?utf-8?B?VnJmQkhzUzdIOGVwcVNlVGhrVHRqTTZUK25OeUREdXIrc3d4S1hjdHlhekJi?=
 =?utf-8?B?dGYxTUNKL3FiYk1ha1B4RGRPbVlOc0p0MUdwYnRrRUNyeUJXeWdZUWUwK2Fu?=
 =?utf-8?B?Rk9tRWdwVDZUc042ajVqcTBYU3kyMHgzQzFZajBlTDVyVkhKWCtlS1NnNzM5?=
 =?utf-8?B?NWhMUnVYcXFuVmpUWFNoL2FSdUo2c3JSODk5RFVLM1pKb0w0ZWNyZXVtVkpr?=
 =?utf-8?B?SW0rMy9rQUZDZlVPWkdjL2s4OCt4SndwbjRCaW8vQUVDVFpjSkhaV1dIUXRz?=
 =?utf-8?B?TmdGT05kNTNFRTNxdndsNkowWUVSS2pObFZMeElLZzZRY3QzRU42L0V2YnFJ?=
 =?utf-8?B?MldCM1RnckMxSjlaZzJRL3RETTlHMzlieDJOQUVzTDhSZ2FsOHRpSHZvbDFU?=
 =?utf-8?Q?WLbNgbUL/Hkx9itDa1BzFz1VF?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0b4f93-3c72-4eff-98b5-08db5ad7fa22
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 15:19:46.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZxyqNPscFkL8m8WaCUV01/efSl2+PbmWBPVcyptc+50qJXgBazmmSfCNkf7Y7G9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a device with a "sound card" that has an amplifier that needs
an extra boost when high amplification is requested. This extra
boost is controlled with a pwm-regulator.

As of commit c73a3107624d ("pwm: Handle .get_state() failures") this
device no longer works. I have tracked the problem to an unfortunate
interaction between the underlying PWM driver and the PWM core.

The driver is drivers/pwm/pwm-atmel.c which has difficulties getting
the period and/or duty_cycle from the HW when the PWM is not enabled.
Because of this, I think, the driver does not fill in .period and
.duty_cycle at all in atmel_pwm_get_state() unless the PWM is enabled.

However, the PWM core is not expecting these fields to be left as-is,
at least not in pwm_adjust_config(), and its local state variable on
the stack ends up with whatever crap was on the stack on entry for
these fields. That fails spectacularly when the function continues to
do math on these uninitialized values.

In particular, I find this in the kernel log when a bad kernel runs:
pwm-regulator: probe of reg-ana failed with error -22

Before commit c73a3107624d this was a silent failure, and the situation
"repaired itself" when the PWM was later reprogrammed, at least for my
case. After that commit, the failure is fatal and the "sound card"
fails to come up at all.


I see a couple of adjustments that could be made.

1. Zero out some fields in the driver:

@@ -390,4 +390,6 @@ static int atmel_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		state->enabled = true;
 	} else {
+		state->period = 0;
+		state->duty_cycle = 0;
 		state->enabled = false;
 	}


2. Don't try to "adjust" a disabled PWM:

@@ -656,7 +656,7 @@ int pwm_adjust_config(struct pwm_device *pwm)
 	 * In either case, we setup the new period and polarity, and assign a
 	 * duty cycle of 0.
 	 */
-	if (!state.period) {
+	if (!state.enabled || !state.period) {
 		state.duty_cycle = 0;
 		state.period = pargs.period;
 		state.polarity = pargs.polarity;


3. Zero out the state before calling pwm_get_state:

@@ -115,7 +115,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 	}
 
 	if (pwm->chip->ops->get_state) {
-		struct pwm_state state;
+		struct pwm_state state = { .enabled = true };
 
 		err = pwm->chip->ops->get_state(pwm->chip, pwm, &state);
 		trace_pwm_get(pwm, &state, err);
@@ -448,7 +448,7 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 {
 	struct pwm_state *last = &pwm->last;
 	struct pwm_chip *chip = pwm->chip;
-	struct pwm_state s1, s2;
+	struct pwm_state s1 = { .enabled = false }, s2;
 	int err;
 
 	if (!IS_ENABLED(CONFIG_PWM_DEBUG))
@@ -634,7 +634,7 @@ EXPORT_SYMBOL_GPL(pwm_capture);
  */
 int pwm_adjust_config(struct pwm_device *pwm)
 {
-	struct pwm_state state;
+	struct pwm_state state = { .enabled = false };
 	struct pwm_args pargs;
 
 	pwm_get_args(pwm, &pargs);
@@ -1119,7 +1119,7 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 
 	for (i = 0; i < chip->npwm; i++) {
 		struct pwm_device *pwm = &chip->pwms[i];
-		struct pwm_state state;
+		struct pwm_state state = { .enabled = false };
 
 		pwm_get_state(pwm, &state);
 


I have verified that any of the above approaches resolve the
regression but I don't know which approach is best? Maybe more
than one?

However:

Approach 1. will maybe clobber the saved pwm->state such that
it no longer works to get the period/duty_cycle if/when the
PWM is disabled? Maybe only for some corner case? But that might
be a significant corner case?

Approach 2. will maybe mess up some unrelated functionality?

Approach 3. is ugly, intrusive and is in all likelihood
incomplete. It also needs a rebase from the culprit commit.

Cheers,
Peter

#regzbot introduced c73a3107624d
