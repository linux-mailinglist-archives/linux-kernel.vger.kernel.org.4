Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7C17240B4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjFFLS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjFFLSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:18:24 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FFD9E;
        Tue,  6 Jun 2023 04:18:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrdtVoZ0u3Gk9mp/o2iGzT70W/dpBQK0DWjlmm8WIc84pHYnWcO0OZtlChTsAZgVF4eHFP9BSCitxaNcWpHVkRVnabC5Y8GsxR6zIQWF6E1hSZa/W2hbhFHAC4gTd/AKqDM0GWK/G63EP1c8lC6mlE2Lf50Sc13dT8m3SJPMsuwgGlPYeTslMg67OnjSj4/QaPCr9fpKouBYMFv2asQ6bj257oftlslnaw2dsHbwIEx93MTFbgUmu6DaetCSLhaZJyZiMNxah9PK3DWMQqRzMp0+d7fnZwEOqM0SqYvwtF6jtDOQlCjAWQkSBgFFWhcX+bSqeBNm/VEgbQRTYyj5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9r5PFZyDSS/B42O/IZ5DXe2RUe7qsi0ee/538PstGxc=;
 b=a5MWnmSZo/KiwGg9k9zd5fLEMA86PDwRTZge3iLvhdKcsH3hJnwiwyvToc0DXG9oo8tdccLCAVSjfYE2n2BbI5EvSEgQaiu+Bnm9D3sBxWtUE8eo55znCLQjFGmx6D0G3HQQ3AxWphtFaWKtvVjeWvxlo3RBsMhxQKvT1vt+XYpsefZl1e8chnMjLs8L4dF+79EfPoE8Z4D1XUEQZNYAkeDgB/7YPnzdQ9akgEr87tQ1WlQ0NMIkiDRbwRlROfxtyp/OyBet1JUx+z+cXf/FvNPJBCrJpoCbU1wFvns63ffoElm9vTUi9OJXDKWApbT/CvTmVL31Ogd9+eMZbSnjjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r5PFZyDSS/B42O/IZ5DXe2RUe7qsi0ee/538PstGxc=;
 b=g8CqzCAnIX74YWM0b9SIeiFEU8lRJjYizP+iHq64i+IHDo78NIeu5UmNtgOeWSBkSbCejegHaVjO7nfrMBbQHcM6Ocz98S+S1YHQI48gqv9D1Ov+iMS62QKkioTtwpv3bZv6G8AVWLT172nvIZkAEqat3nHgomrdNBOVEcP0n6MGqF9n3Qvs8+EmAJn+7Gnh89mnDvvll3cesIDubg6JiRb3xmO7c+qHywvEWIDw92sfdzKuSXiRgoK6mW25y24gscUA9e6t7cxrq3IqoFkbJes6hZ2KbtUJj1FCCGPqtGAepsMKCjf/wuvzJDona+eg4AJGXlWH6yO6JgtoC2iveA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DBBPR04MB7644.eurprd04.prod.outlook.com (2603:10a6:10:20c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Tue, 6 Jun
 2023 11:18:21 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::db34:4ec1:a01c:951b]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::db34:4ec1:a01c:951b%4]) with mapi id 15.20.6433.025; Tue, 6 Jun 2023
 11:18:21 +0000
Content-Type: multipart/mixed; boundary="------------9KNNrdL2w9q0Fq8Jo6fAmT30"
Message-ID: <726a6f5f-5338-50a9-3081-7c02194dd7af@suse.com>
Date:   Tue, 6 Jun 2023 13:18:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 0/3] USB: serial: return errors from break handling
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corey Minyard <minyard@acm.org>
References: <20230604123505.4661-1-johan@kernel.org>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20230604123505.4661-1-johan@kernel.org>
X-ClientProxiedBy: FR0P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::7) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|DBBPR04MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 24aed4ba-4691-487e-a8be-08db667fbc3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+/mvIUzMlGKw4dbuuLuS8df2D404pbpkLJWVkojcZ/hPP7svtu1/ZWdsIF+E1oDZj0FRImqei4RZhvLCxsHlu7fzWQHSbv7WR7a43m0/0THea5Y7n94NFw6dZm+q49B/FYuwnXbQZDs/4k+sdKb24PDYr/rmbbTmJtnbIDA8/XStkiN1y/7efAyOT9MvTy2/sJOW6sb5hzzqBEIieHM+oVt+eOjbc+7QjK72njah23ZuFvcoDguyI6fBhBbMpd3N8gPvzjN8QW+SlE4YdMB+b69/l+3qey11sz8oHCwYGy5KUxczex7FxZ7yAT+8KMK+fc+WU767kiB8xkFVSUPKrjgT4ohxTZ/yg8nmeVlmHHkeOY9m6FknkCXWqkGf1CGMdXc6XlahU4Tpc1JV5UF4k3MlJCRT4KD9bcbd1ENCODfZUIy5iA73/Tm531iO7/Y0gotZvod8D/rt1geb1hhWW+9bnGy+HcyGGEnI5e1do6xrQdffJ0b1K0FfpmTeCHrlmYqsWi7kBbbYMlveBlmWHFPApKcT+gvG23tCIVdn8mC8HpIN7MMV1H/kTebwAIuWzuMIQ5u7avTPpUd/ExjCgMmgCd0PGMLn10s4Cs0zKQ5hbbnujbO7ZJdnAFlvXJPkS8CPbktp9ktBzqUbBobRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(2616005)(36756003)(2906002)(38100700002)(41300700001)(6486002)(316002)(4326008)(86362001)(33964004)(235185007)(5660300002)(8936002)(8676002)(6916009)(54906003)(478600001)(66556008)(66946007)(66476007)(31686004)(6512007)(6506007)(31696002)(186003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUtibG5OQVU5V3NtbVoyTE54b0luQVB4YjNPZU9iVVlvY2JHTzE0SzlBVEpI?=
 =?utf-8?B?UVdqK1RoM0pMWUcvK2RXOUFLWFRwYlBCVDVBcXFkWGV4SGNsbldlT1hnTVRG?=
 =?utf-8?B?YXFnWEpSV3gyNUtvazFVQzNvTUllaUkzbCszZWdtQ2VYam8reG4relc4ZUR1?=
 =?utf-8?B?ZytsLyt2QnBCTjhJc2JPYmtnZFd0VzhrWFMrazBmNzlJWlBzcW8rQ0cyMVRa?=
 =?utf-8?B?bFFJSUJOMjdsNGN1WG5iTkdocDVNOXlQUVBHdjRBZ0k3TExoNGRjMjVrQkZS?=
 =?utf-8?B?NU4zWFQ5UGdSc1BoUWtTNEhPUlpxbTNmRFpZNFhUZVdSQ0NyRzBTTnVLSitT?=
 =?utf-8?B?L25RbmJUL1hyalRtQWhnN3VmLzJ0SkpMbmhFZjluck1zTjh5L3l2aFdKeCs4?=
 =?utf-8?B?bVN1T2xoWm9tQkUyQU13dXNIVzhoTkpHVC9rQ25oUjVEOElndDdrOVZiOUt1?=
 =?utf-8?B?bW12NUpXeXh2U1N0NUxtYkZ4cFFOeExHNGhhVHpHejFzbXg2QU16Q1gxVVND?=
 =?utf-8?B?YWdYamsrS2VCZUtOZVdhTWNWRks5eTNqOEl4WXcrZXVhTDBBbGtqNWVsMEhz?=
 =?utf-8?B?T2lKKzNrbjA2OFdmV0ZOMmFLK0JBQmJLNTVzSXozc092aVBQQnNuWkZnUG9M?=
 =?utf-8?B?UUlCVHpUZlVCRFd3S2dIN1NzNG05eEdWWTBZOGlHSHg3ak9mQUovaEZMQ0Ft?=
 =?utf-8?B?VmQvOUVEZWpScFNiaGVDbUx4NkVQaDhkQ2VnL1VXU0ZkalRERFRzS0h0dGJN?=
 =?utf-8?B?eUk1OUFPZTA1S2c3MWMzU2ZPK0VWeXoxdlEySWpPOGIwV2h2dVRDUFdQWEox?=
 =?utf-8?B?UmVlTVg4VjdIcUxMM1pyczR6aUg4ZUZaN1BjUThtT2orRFdYWlMvTlAyTmtZ?=
 =?utf-8?B?dmJaM0RyMU44czZsOU1peWJ6UnA1TkpScDVZd0F2a3BHRXNEWExrTStmMnhT?=
 =?utf-8?B?VDVRQlg1ZFFZWHZxNVN1M1o0akIrRS83alVwTitOVHZzd3NFUDFwTHF0Sm11?=
 =?utf-8?B?OTg5aGlPYVZtWitycG1ZS285b0tXVUZDZmwzaGtadGFDdjZQWFBKRHQwbHY5?=
 =?utf-8?B?bkI4aHBzMmVHNjNrbk05Rk9taStTTXJxRFR3dm1vb1YrVTBoRHFUeHg2Q2tw?=
 =?utf-8?B?OTlnNHljU2xadktmNzFwN0VLTHRNZVRQOHNBM3o1K09oR1Njd2FCRk9BRFJT?=
 =?utf-8?B?OTNTd3RPTmczN3BqcEdMY3l2WG53dlNEaEc0K2VKR0V0R0Y3bDkweTRTWTFm?=
 =?utf-8?B?djU1bytBaXlNbHYxaEJjakVJeWNiU0JmcWt4VjBNcVRIS3RGOEZQR1I2YWxC?=
 =?utf-8?B?bFhjZFQxamMwV0Y5WXZSOVhld3hIOVBJck16VU90QU1VWmM4RzVXemRUcjI2?=
 =?utf-8?B?Rmdibk1JdkhDcU1oQ1NXNS9FeER2QTJ1RjFJajYyZlhRTXJ2TytMbmcwTTRm?=
 =?utf-8?B?SkxwMHhWaURXTEZ0ZlNpY3htcDE1QmkrSkJUSG1EMk53TWFCWnl3RU9JSUNo?=
 =?utf-8?B?OGJKcHNlQ3gzMldqQUozOFR0eUFkNXpqOGFZVTV2WGc2dnBueXEzVzJWUGhw?=
 =?utf-8?B?a2h2ZnZtR2pkR0R5dE9tT2YrUjJYS0MyR3I3MTZ3Z1VRaHR3RlBaaDVlbDZt?=
 =?utf-8?B?NHI4L3JQWEdGL0h4UUJnaVBwU0hlTHVjQUtsRVZYZENoNmRrSVpnT211UlJU?=
 =?utf-8?B?elRadGk3anNLaUdDNEh6TjNQSmhtUmcxdDNIeVRHdk1uSFUwSGtKZ3gxcTJt?=
 =?utf-8?B?c0xVWm0ySzRvL05oYlZaT3pyTGJCaUpvYzRSV3Bia3pnOVlxSzVBTzZ0YmZL?=
 =?utf-8?B?VzAyZnlSTWZCM3RFSDFXdmFWMmVZWmRQM1d4TFdEZTFMVTJPN2gvY2Nybng4?=
 =?utf-8?B?TlZma0E0YVJnNjlIVmdoOWE1YmlzNVFSbHA3SERMRXNqelE3djN6aGdadC8w?=
 =?utf-8?B?RVFBYjJzSFh3SUZDOWxxNG85WE93QU5NYksxZWNEWXR0L0o3ekk2cWQ4Y2xK?=
 =?utf-8?B?NEw5R1NxUVpYc0ZoenBucndGVDByR2JkVndEY2dnZE5LTGpWTG1yTDRXVy9l?=
 =?utf-8?B?cHpuYzVUdCtUNkdYRXBTMU1wOFEyRU1uZHFmRk94RTZHRC9Rbk13WGs3cWpw?=
 =?utf-8?B?bmFDbzNSSlV1MnR6NGdFNlJIV2dzRStNS09DTEk5c0xwZUtMa3hKSUsvaXRy?=
 =?utf-8?Q?ooBD5Xz7HqAHmYxbgn6tu7I=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24aed4ba-4691-487e-a8be-08db667fbc3b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 11:18:21.2932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmLPXmg7fvAdFh3/s7iEaduXQeeZs/S2ykVu3++k1AKNwFzaWs75Ce/fEy+H/R90QmdXFXVtrr8YU50AQC08ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7644
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------9KNNrdL2w9q0Fq8Jo6fAmT30
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.23 14:35, Johan Hovold wrote:
> This series starts returning errors from break handling and also uses
> that mechanism to report to user space when break signalling is not
> supported (e.g. when device or driver support is missing).

Hi,

do you eventually want this to be done for all serial devices?
That is does cdc-acm need something like this patch?

	Regards
		Oliver
--------------9KNNrdL2w9q0Fq8Jo6fAmT30
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-usb-cdc-acm-return-correct-error-code-on-unsupported.patch"
Content-Disposition: attachment;
 filename*0="0001-usb-cdc-acm-return-correct-error-code-on-unsupported.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAxNjQzMGQ5ZjEwOWY5MDRiMmJmYmFjNmU0M2E5MzkyMDliNmM0YmM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgpEYXRl
OiBUdWUsIDYgSnVuIDIwMjMgMTI6NTc6MDAgKzAyMDAKU3ViamVjdDogW1BBVENIXSB1c2I6IGNk
Yy1hY206IHJldHVybiBjb3JyZWN0IGVycm9yIGNvZGUgb24gdW5zdXBwb3J0ZWQgYnJlYWsKClJl
dHVybiAtRU5PVFRZIGlmIHRoZSBkZXZpY2Ugc2F5cyB0aGF0IGl0IGRvZXNuJ3Qgc3VwcG9ydCBi
cmVhawpzbyB0aGF0IHRoZSB1cHBlciBsYXllcnMgZ2V0IGVycm9yIHJlcG9ydGluZyByaWdodC4K
ClNpZ25lZC1vZmYtYnk6IE9saXZlciBOZXVrdW0gPG9uZXVrdW1Ac3VzZS5jb20+Ci0tLQogZHJp
dmVycy91c2IvY2xhc3MvY2RjLWFjbS5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jbGFzcy9jZGMtYWNtLmMgYi9kcml2
ZXJzL3VzYi9jbGFzcy9jZGMtYWNtLmMKaW5kZXggMTFkYTVmYjI4NGQwLi43NzUxZjU3Mjg3MTYg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2NsYXNzL2NkYy1hY20uYworKysgYi9kcml2ZXJzL3Vz
Yi9jbGFzcy9jZGMtYWNtLmMKQEAgLTg5Miw2ICs4OTIsOSBAQCBzdGF0aWMgaW50IGFjbV90dHlf
YnJlYWtfY3RsKHN0cnVjdCB0dHlfc3RydWN0ICp0dHksIGludCBzdGF0ZSkKIAlzdHJ1Y3QgYWNt
ICphY20gPSB0dHktPmRyaXZlcl9kYXRhOwogCWludCByZXR2YWw7CiAKKwlpZiAoIShhY20tPmN0
cmxfY2FwcyAmIFVTQl9DRENfQ0FQX0JSSykpCisJCXJldHVybiAtRU5PVFRZOworCiAJcmV0dmFs
ID0gYWNtX3NlbmRfYnJlYWsoYWNtLCBzdGF0ZSA/IDB4ZmZmZiA6IDApOwogCWlmIChyZXR2YWwg
PCAwKQogCQlkZXZfZGJnKCZhY20tPmNvbnRyb2wtPmRldiwKLS0gCjIuNDAuMQoK

--------------9KNNrdL2w9q0Fq8Jo6fAmT30--
