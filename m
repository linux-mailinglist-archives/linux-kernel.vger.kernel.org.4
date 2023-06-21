Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29335737897
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 03:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjFUBJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 21:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFUBJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 21:09:40 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2015.outbound.protection.outlook.com [40.92.98.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A614710CE;
        Tue, 20 Jun 2023 18:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+n3wA1WwnA7Z1xUoVpOoNvsLcicgRVRYB+4Pdp4oa/naPq7B6Ta6Y4DTX8PLXgt1LQdH56Fncw+qw8OSu6VTTHWwTN9LfU9QRe/tW1I9ScnGUk9c60Gujl8N0l5UPpa3q1fTEpVPiHEkp3nhaWA+XVvuhW1AANRpwON1Q8OJNDOm4L20vaWhSDYQhZaZV77mC2tmf3/HdUXo3oLxNc8X2u5hH5BlrUVk1gJFLkCCDw/3vYZ3UrBnCgd4wnbXZMccwv1QEqCQH9M6BiUXVJDlZw2FzqAzjtUC/e6Jtvpoa812FHNA7XUzyBnMt4wQSDcm/N/F+5TRjg4u+xS+89gHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6XiiDamQ5JTshGirPL6urOCA+Ug6CRYnz2IjwBbQx4=;
 b=hz9IoQhOw27l+SqCAi4Y6/LuWuQc9rZ3fhHp7phV8pgVQ8oQQvm/c55ed02oJutDumspjnbC8cdSqbgCBYdv9ab24tVtDebhDu5nW3yzLJgTG4BhJ0ab63+73Ypi3oM/4IVZt06BZeW2CPhL6U+wqThQYp2IkE+hRPKHAYn2D1u8/TnvcoIPsZ+vXC77m7tj5vwzbK3ZX45QsAABM9kSfF0jZHb3chTgLRcd6D5X+3/1QGcZmsQ1+Tfk7tsfgRqZyWabgPPD+HMuJDZ+TliildBBjUJznMMXpXxopJQcg6D3N3VkDPkL5qWsNxD/0+4f1IwKjVgR0VQ8kG86egrdzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6XiiDamQ5JTshGirPL6urOCA+Ug6CRYnz2IjwBbQx4=;
 b=AsioOccag1ZfcVAxHFJZSRXA9+8p28a6ydID6Ykt8FSj51GDo59yi7gAVJ3g0G3gWIWeXAmkTMqkH92Y7Bw9UOQtkzH670DscG39CvzvkBCQXC7nFDNiR6bSGhc9CqVOZnCxm7vqUc5gM9MkoziyuFPhzMBveMzuRdGUYB9Mv18FOHonsY2tq38/rdXXoHTLCicfTfuUDNyreqgvcBR6VSDw1UhGvKSWLKF9RlNQfv6M7xOxgRvsrl9c4KVxSADd6jxNtfFjz2QOCskUykENVvx9ZZbYeYzX6xT8NV099Nu0aVrBrTQb+RGSroz5E40mFS4zFHSy140JVhIwN2S1oA==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYCP286MB3852.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:43a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 01:09:36 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 01:09:36 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     sergio.paracuellos@gmail.com
Cc:     angelogioacchino.delregno@collabora.com, john@phrozen.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, matthias.bgg@gmail.com,
        tsbogend@alpha.franken.de
Subject: Re: [PATCH] mips: ralink: introduce commonly used remap node function
Date:   Wed, 21 Jun 2023 09:09:25 +0800
Message-ID: <TYAP286MB031554B338E2379CB87273ADBC5DA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAMhs-H_OtDgJmBrcrN33goXDM19WJr1+Za+G9tibMZrO+9KL1A@mail.gmail.com>
References: <CAMhs-H_OtDgJmBrcrN33goXDM19WJr1+Za+G9tibMZrO+9KL1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [j80E4g7ftTsQVzTKlWVne3b1o05LRWT/]
X-ClientProxiedBy: TYCPR01CA0168.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::8) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230621010925.3269-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYCP286MB3852:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa2c339-8586-4876-f615-08db71f42dde
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3HfGXC83I7pQBgvIeLzacxzsFoz2xdhWVwicsTw5T/Wpe8CnyiGm2tuRl4W6WMaJkv3FIgcN09r96Hn/fvEl5Bf1LiDMAjtl+CGPdIfiOU7BIIsDE0Ej5k7hEI+ncpnAsrtexRLX2cB5FNJZPwtdPIHw7ITmt49rJfH2/jARhGSjmMVwluRyJ5kkBDgiAaaYKiCguWUb6oTrawT8hVn545rA9Y47C69TJv8RnZuqDvZoiPCfblnE4sqgmH65H821qywxXooHFplpz9rjC7xvjWKvUT8zhp5uIYAAI5tqjVM2k/fhLXAP3SKTceI5Lc02I4d9WYdMgYvJR43buiw3RV9U3/+wAlbQAe6JFIZM3HEL8ge/72OilKwUgRRVIdPz9Ga4KkDR3EbXVEZcMIdYADaoJYht7CVTFetpdgNnscwfBDPatFxRLiQJGtqe6omzJQf/EeCXQ9DngygWXe42DSYNVMGshy5lF09hv7gyfNprNr85xnvNgDTOzOxhPZ08rVYFzQrhJmiHpuWgngmYpo/WCD+Ra50lhiD4Eaprf2c4y6uGRuwTT0JpL/krFI/4jf/PGlXJ785o0eLL+VTvXo/1hAOF4OW5x4W+a9egfo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elhkTG1RUHBUNEhDK2xSNTFONnpxRzY1TEE0ZE1ZS0EwTUlwOHdlN01SRGxD?=
 =?utf-8?B?dGlhQ2pmQzdyd0dtVHVNR1hIM251UDlWVTdoNm56ZWk0UWk0dWh5b1dXYzQv?=
 =?utf-8?B?amFPb3NpYlBSR0hkZDZJOStENjVURENNQUJaMkZmWGFWK1ZxWWFCVHFYSFBW?=
 =?utf-8?B?OHB1VjczS0VHcEw1RHVOYkR2UDloaGdSUjV1VGd1UTJ0OEk5N0RqTngyaEVZ?=
 =?utf-8?B?SWRPZFVJdDJ0K0Y0dXpNQi9kdTZ6SDdMZkI4R0pLUFlqcEgwT0N4NkF3QWFO?=
 =?utf-8?B?NUVHczRBcHZwdW9nU253a1g3bW4vcEdFZ3FrN2VtTEd2TVF6S0tTVUN6OE1s?=
 =?utf-8?B?bHFxUnMyVk5FTzAwMVVhOGJFdkxtNkc0OWdNZDkzOTJLaENRejMxOHZCbWJq?=
 =?utf-8?B?aHc3Znl4NlNZM1FlMHRHVHFPZW0wL1NJb2pqY1ordTROWjZjZHFYMjBCWFhw?=
 =?utf-8?B?V0ZOc3N2d2x3NTJTNEIvaWFCZS9VbHIwcFFYVzYzZDNiY1BVWTRQNGhrb3RJ?=
 =?utf-8?B?M0VUMDUyTXJoWFdCNTFhZHY1QktyMmZnTDZlWG81dGRLU2JjcG10d20rbEpr?=
 =?utf-8?B?UkxTcXArc2xFb2ZwRHJhQkdHb3ZWUHd2ZjhiYjREMnhEeklxQm40V3dZcTMr?=
 =?utf-8?B?NWlkNW40SzB2T1l5V1ZPbldlaEZuRlVvZjUyRWpqaVRrd1g3by9CS3FtSWc5?=
 =?utf-8?B?TE1mWUY1YkpyMUt0RjUxUGVtR05rSnpJTXVQRHNrZGlYaFFuWC9GLzhkdkZX?=
 =?utf-8?B?b0tFaENvdWlzZ29uaGsydGRuRWFYUDV5bktDVnd5ZXZsM0llaUtPMFBLSGhn?=
 =?utf-8?B?TUtsbHg0d2FTcEhWaldRL2J1YkJ2MkJXblJXeThmNld0Y1gvclhmVmVJK25M?=
 =?utf-8?B?YlZRd054ZjkwZlc1OGxvTXpEdkRqMmY4UFM3bHZnL2F1TzhIbVhLa3RlZ09W?=
 =?utf-8?B?T3R6dHYyVExtYXE0d3hobStLWkE5ODk4Vy92Rjl0TVpKQUV3UVVhWThRVHJM?=
 =?utf-8?B?M3h1QmlEbnIybyszeGg0VDVybnFkV1BMMyt2MlNCQmZ4OHl4aWFOWDM4YktH?=
 =?utf-8?B?UjZKSU5WTXVyMU5saHBJYzR5bzdaZjUwaUNjWUs5ZHNOc21PQjFzSFVZNWR2?=
 =?utf-8?B?T0c5Kzg1UTRMMXVhUklkdUtSS2RIdFhpYkdTNkdmaFBxNGJoMStFTVZyUnJP?=
 =?utf-8?B?UTVIT2xVamxSNjRQcTRsZ3lkWlYvdFU2a2tVcFhFVDJ1aHg2WVdtU1pSQXZT?=
 =?utf-8?B?VGlrV1hka3FNNUgveVJSVW96a2JuR3Jwb1Jza0J0UmlzWVlVTUt6R2RoNGN5?=
 =?utf-8?B?aSs1cThZMjRsbEdBaFhGOGUvSjFDTGJBL09tMlV5OG1aQnVUQlAvaGhNV0dy?=
 =?utf-8?B?RjhJWWFXbzd1bWNIc29mODY3WmVQbWdOaTV5ZTNJSUdaZlRVWWRFc2hXQTJh?=
 =?utf-8?B?ckhuT2xMMktkaFZzazFOa25lR0JnY1NxcmV3UXBxNXZJamFqSnZyck9DWUM5?=
 =?utf-8?B?SFdXRGlGcjJBVEZsV0l2Zm94UnNXOFk5VWtESWN2bGdUUUhqRnRnQ1lWNjNG?=
 =?utf-8?B?MGJjZXdPY041TmxHUTk5UmRGbHdLQlhVVHV0VUxyTXk5a2pzdFNSL1QyS2RS?=
 =?utf-8?Q?wLiCfsSJ5ST/2DUhkFYRF3gyJraWER1xU9BFErm7ZahI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa2c339-8586-4876-f615-08db71f42dde
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 01:09:36.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3852
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Jun 20, 2023 at 1:46 PM Shiji Yang <yangshiji66@outlook.com> wrote:
>>
>> The ralink_of_remap() function is repeated several times on SoC specific
>> source files. They have the same structure, but just differ in compatible
>> strings. In order to make commonly use of these codes, this patch
>> introduces a newly designed mtmips_of_remap_node() function to match and
>> remap all supported system controller and memory controller nodes.
>>
>> Build and run tested on MT7620 and MT7628.
>>
>> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
>> ---
>>  arch/mips/ralink/common.h |  2 --
>>  arch/mips/ralink/mt7620.c |  9 ---------
>>  arch/mips/ralink/mt7621.c |  9 ---------
>>  arch/mips/ralink/of.c     | 42 ++++++++++++++++++++++++++++++++-------
>>  arch/mips/ralink/rt288x.c |  9 ---------
>>  arch/mips/ralink/rt305x.c |  9 ---------
>>  arch/mips/ralink/rt3883.c |  9 ---------
>>  7 files changed, 35 insertions(+), 54 deletions(-)
>
>Awesome! More deletions than additions in arch folders is always a
>good thing :-).
>
>Changes look good to me. Thanks for doing this!
>
>Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>
>Best regards,
>    Sergio Paracuellos

Thank you for your review. After your new system control driver[1] is
merged, with this patch, we can add more compatible IDs to the list.

[1] https://lore.kernel.org/all/20230619040941.1340372-1-sergio.paracuellos@gmail.com/

Best regards,
    Shiji Yang
