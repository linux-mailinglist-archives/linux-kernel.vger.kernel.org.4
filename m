Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CAB679648
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjAXLL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjAXLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:11:54 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2092.outbound.protection.outlook.com [40.107.14.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBD32138;
        Tue, 24 Jan 2023 03:11:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVczHfO8Z3ZMycTssf8aBdh8lVJEna9gxEKxGRzAhJXTHCtW3+8UPpbduNOLY0kj3IbbM7da+1boOY7jpoGG+0lR2xUVQ5SGUOO5OtVdvRXFBtzb8WEKFP+keIdosRExwCm23Jzn7EHg3ZYMHGADUR51+g5FZ8iYOcxzndj+dIjYMmUJQOhBi2Pjc1OmJ+U+r/pg/muap8EiN9iXFFiRQWvOzsEulBJpeiv5joVL9puG8UCM/MK5LIGHg8j/Sd4zb2+fwvXYUICMhLvI9t33SXvgWaOhEPgx+hdjsVYYn3tx2OaenmEbeDbyqNlt6eHTES4Fw4EaaRt/ZndkWVBLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YolAmUD573RBQCLwILQLutytu2Y4odDYEs0bl31k7Q=;
 b=Y+S2TQXwEw/mzZSfmjst14AYEGjTqvE2jLnbAm/ujSDl8vh8rPrQcvtSVkw30b+KbPcNIqBUkre78uRkeaKrfbjq3azfJC8Myrg2N9HnJYjN7q9JDVHzU4LobJjiHNO31QvIWfvGxh43ml73WcmG42kRp5SnszkR2sQINdjQXHPi/zgTAJiZp73eSQYcAO6YyZb4oYxuR8gxkfgV0yYFyS6znQl5xUYL3hCgAkv1XSjgYf2GAeCo7Fkjjn8Z0TDfD9B8xpzD1RuhlY1BsV9gBDhN+rODfUmil0b3eXiXqzzuKDG0H7JnoT8PPl5RENk3QdKBbHsdQZ5VVgviW5fMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YolAmUD573RBQCLwILQLutytu2Y4odDYEs0bl31k7Q=;
 b=rflt60ImBdFeeLjr81eDM/7pKLwJwmP4PzfK+//GlWJvq9Y7Rp0B/VOB8tL44uIllqQS9I1BkArQDfkDvfOsEvXFQylz2Xvw9WhcjieI8HB2DLNgytwQMzP7RltsLPQ3Ukjx+MdKVbbbo6papwfKpWkq6xBoePsoMgiqJ+WqOjSwjbSXRmg/eteP4Igvec0G/5bmS+nZenEWJJz7DWK8SGeQi9OwitnFjYTDGNn/Y1I2jW5P/9+FYwCZvwUYhLgaM1W+oFXcHJ4FGmzdNSVnRA7uifZqOxDa6cXQcYyOJREdgPgzNwdsKat0ToW1xhRTsvrtoc8dTrvycacVyOVe/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by AM9PR03MB7995.eurprd03.prod.outlook.com (2603:10a6:20b:43e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 11:11:50 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%5]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 11:11:50 +0000
Date:   Tue, 24 Jan 2023 12:11:47 +0100
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     manuel.traut@mt.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org
Subject: [PATCH 0/3 v6] input: pwm-beeper: add feature to set volume level
Message-ID: <Y8+8824hy/fWkpEk@mt.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: FR3P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::16) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|AM9PR03MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 93bc976a-3aa5-42f5-dba9-08dafdfbca5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGp7846qUFsmyh2V2OOk+CcwIOjW47/+rzF1ewOUI0pFMrDHmciASol1l3ROoXUZPtoUL3jhU4qU4kSYTtVYPBT2Jw63MMbpMYVBoRBDmJlu+zbvSKjVVu5kXSEbkmcc79S2XVkS7lCp9H+TsErMiEjSI5nUkHjNZf7HBPjzKQk9OgtwgLjC/K8Nl9CfFZt+95AAauFH8I/dDK6V70a5KTRDCXE3Tpqj9uBGamrapQ/bQuMWdzRw7lLg4E6bNBwWKDcS8XrNpICdKPiFOLh0/iV2Kii1J0wlyHrojea/eYYCp8tnkI2NeGfFkoBFtRigrpyeyBHZ72c58XE7Kf4kinynXd459MQRAp85GWUUw1Aq1CfbpEonCUvShPPGMTeLWZVfEMMpBpHkmnayD8bQhVIrR70jHSwgEaCBtPJciVXhV8OABA1kUY95DK1Ksjvlnppygx/41ExEri0gYkSWDrSq+ZpI2XwSNoAGYiMgjM1viEauWmtP/FgvLgpmaNx8inGPTmlARO5lnEKASCbbf+jz+4fn1WMCd+wgJtiH156ZXH3Sk/t0BdP2O88ieaLHj9LQGk5RoDalwYF1PxEPh64bFZzD9ZRUBmBsc8kwRoHJ0VlnlzKZYOk3AJIghya7ZFdagSwIAh6ERIT4RFIndo6ntEDM4hvXd+e14DM+m1pOJh7HhSoyQDZO2yGab4X79SXUVcN79oUzJv/cPYCkpBNUisaUWSj5y/5EFrqZTlc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(36756003)(41300700001)(86362001)(8936002)(5660300002)(4326008)(44832011)(2906002)(558084003)(38100700002)(38350700002)(83380400001)(966005)(52116002)(478600001)(6486002)(66946007)(6916009)(6512007)(26005)(6506007)(186003)(8676002)(316002)(54906003)(2616005)(6666004)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFloSXFiZFVoa25adkJzOHdxVUZRdXZGMTZTV0w1M3ZZVTZxZTdnZ2VNMS9j?=
 =?utf-8?B?bEV3bUdYcHlyNXp0a3lkSnV4YWhIZXhHYVBqK1Y2WHZFQlR2eDdzOG9yVjYw?=
 =?utf-8?B?ZVhCYTVlOWd5MWdpMW1OeVNkYzZ1ZWpyOXNrbWZKZ1JvK1pDLzZsMDlna2FW?=
 =?utf-8?B?SjcxT0IyY0hOUDhGZ1dlWTNhUENyZHRhZWw4Z3Jub3hOaC9RenR0eVVKalJQ?=
 =?utf-8?B?N2htRmJ3aDE1RWk3YlhZS3FtdkQ5N2srM3RUYWY5NDREZEszS3k1dWltUG9j?=
 =?utf-8?B?YVlqaVA4OUI4aEpCSW5zYWovYnVxUEFLV3pOWWUvaXducmRiUTJ2NENHc0x6?=
 =?utf-8?B?cVVvRWhlbVhvb1FqNTNRRU5QNVBVNVhHTEc2b3MzVVhYNldUd2lhWWhTL2ds?=
 =?utf-8?B?RzBKN21DWUNMV2M2clZ4L0kvZGNSVEF5QzEyMU16N2R4ci9xYnNQUVI3ZVc3?=
 =?utf-8?B?L2V5bnpNZUFRMUVQcUVVeURMd1JNZFdYVUdpQzc5NTR3eFFmSm5hNGxHNW8z?=
 =?utf-8?B?blV2MnQrd2VOOVE0dHhWRkp5amVhb1h1clhGTHJncEp2SGt6TUxqby9CN1Jh?=
 =?utf-8?B?YnVHUjltSUJUNk8yMDYvWFBubUpsUW1JQkk2N3J6ZDVYYVJSeEl2VXYyZ1ky?=
 =?utf-8?B?WURoR0VHZWYzZHc4Y01wNFVySlpMWms0VFFLKzF2MGd1Z3VLYzNiWUZCcGlZ?=
 =?utf-8?B?ZzVianIvcWxGR09kcWZzRmtGZUh6TDB3UVN3Qktmcm12Y0IyWTZOVTNjYjlx?=
 =?utf-8?B?SGY3bXM2Z3ZDNUQ0RXpxWkp0MFBvYXVzY1BMY2Y3RzlmY2RQLzE1VmdhbTlP?=
 =?utf-8?B?S0tZMW90VklZV3VwMzArdzZsZGpIN0Q5b1RTUDZqRzV2QmJiZlRJeUFTY3FS?=
 =?utf-8?B?WWlSSUNNMldZL0NVc09BS0Q1SnBJaENmT2JDSTAwQjhzZmtTdUNEMjZYSlZr?=
 =?utf-8?B?K2kwUXNuSDFxR2J6SGc2MzFId1MwS0owQlFLemxaTlh4RWcySlBldW1NKzQx?=
 =?utf-8?B?NWphQ01MNVhhaS9aaGw0aUtHb0J2MHJYUFJpRjRqeWI5Ykd1VWxXRXFpOXRP?=
 =?utf-8?B?b2tXcG1VczcyN3N5ZS9hZU5VeFF2dmNVSVRJb2tLVkg0ZkJERlZaYXVTNGpZ?=
 =?utf-8?B?dXloTThqb3ZQTFdCblJtSTM0Wlc2S1E1ZkRWdnJERmFWcWt5N0NCakFQY05G?=
 =?utf-8?B?eXd1OUo2Q3pXc3RhN0d2VngvSnphZTlQbnZQalNMZ0h3QUFwWUlzUmpXeHl2?=
 =?utf-8?B?aVNpa3FtMmFMdWwzbGFqaE9tUjhlNGdkeDNqSVRnTWxwU1ZsTTVsejFiOHlB?=
 =?utf-8?B?anRGUStXVHBWelBiNVpaazVPejR0WkVPYXB5SlpkQllLa3NKdFlWOFRTR2RS?=
 =?utf-8?B?eEUxcGQ0T3M0T2dZMi85YS9kby8yMGpFMUJxVDZ3ekFjRmgyT0NpV2VWTU5D?=
 =?utf-8?B?VWtiVWt1RnU5dTVXc3Z5Z1dRcnZEZmI4eUdwQVRySE5ENFhrNi80WTR4Z0xG?=
 =?utf-8?B?cnJURGZHeDBORVYrS2R2bW9QSVo3NThHcDhYa1NNNFN6SG5NQnpXVVZBZG1p?=
 =?utf-8?B?UmRVTVRkTEtqS1ZQMGJ2aUFXL0FlN09RcUIwTlE5REFadWRaNTVydjRaU0NS?=
 =?utf-8?B?eEd0T1ZQcVdrT0NCWDFOZCsxaG5Ldk9Ld2QydHRFV0ZVVFVvamdWRFFic2FY?=
 =?utf-8?B?U0Jrc2dNR0crNWhEMVhiVWRKS21zTWlvcHFjSU53MFcvM3AxZ2ZocHlsSDMw?=
 =?utf-8?B?UHMvb1YrNy9hM29mNTRmalhTK2R6L0gxZTF6Q1RMWWxaRUJxU1A0Q1JwWHBw?=
 =?utf-8?B?QzRRcXAvbUR5U3pyU1krQUo3eEQ4VHhKTVVTWmJlTmdReG9LYzAvRS91cm5t?=
 =?utf-8?B?VHFjMFhtVmlSUE5TSnJsbDg1V1hpMjMrczBpV1pZcEFKOENUS0I1YUQyZXBX?=
 =?utf-8?B?Umo2VWV4aEFwaFkxa2dvSW1WeCsrcU1XVUVlS3FYbjV1dk10ZzdRRFJKbEpH?=
 =?utf-8?B?WThsdlhlTU9CZmZxNGhCQlhHNHc1OGloczJsS2pvZDRDMnZjdUpmcUpqdlhp?=
 =?utf-8?B?NGZ0UU5kT2JJa081Vk8ybXFJYjk0bkNwSkxKRm5rVEkyYXlaaGFZUm9xTW1r?=
 =?utf-8?Q?+4AjUCvdkaLnBbAYOget21kW+?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bc976a-3aa5-42f5-dba9-08dafdfbca5b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 11:11:50.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMv6aZ5P5zUaIYwbkr7UIF0OqfiinXyLrIyBCBFDjOag83hpVV9RNI3iyeZAWEimcCsEGqwO4sZ6duzKqkO5ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7995
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found an old patchset on the ML that enables setting the volume of a
pwm-beeper via sysfs here [0].

This is an updated version of the patches that they apply to the current
version of the driver.

[0] https://lore.kernel.org/all/cover.1487323753.git.frieder.schrempf@exceet.de/
