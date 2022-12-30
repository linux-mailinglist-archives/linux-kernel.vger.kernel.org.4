Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967B86595A6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 08:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbiL3HQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 02:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbiL3HQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 02:16:06 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2120.outbound.protection.outlook.com [40.107.215.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBBD16585
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:16:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzRN6mlGdvvXAa5YudUQc2SQS5LBnB24lup5tS5kTZrtee8dJYgXsZ1K5YBIBhfIqaaSIBymTBpiUmNobhvb6mRkCOJl8zQJX56C7SPFnUY6D7kY2UBhBlApYDC3Rbu3UycwiklbadXl5PaArtcelnNG9InMOcTYMH+Nyd34CH3v1fF1JHzofUwq/EAJ5goofeRTj0Om8hxl4VOULmCkpiYjE5i5BkgRl2MGKDf9w6K7Hr4CARX3yWorqY224UGzKQRq9hFI0gQDa5GeUkbyZWI/Fvy4vulDiVK49pBHn0MCc1cZmbcXmuZaZf+qI+TDkT/n6rcHDNy0pUrdRGncPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUGNjQ666r4BsIJIniUKiM5v39nRx149/s/osbac260=;
 b=HdY5Ny10kErCLiW8ntvwSnWgHQf3ZhMLf3xyy+zEVBZZM0CQ7XrHwTuqoW9ndlQGPbLIVPz1bcJwSggX4PE+tcNjGJg/G1gRNlAfYYja8/iXljqX2GSayXLhZT2abxHXFbT4RIqgwIWsRjnxuUVoAUzHHQ8WX9145TmUilbXh6K4JFQdHgWxBjheu3wTlaX0+XX6R4aHte0pV2TUaograQSwOfvfyJzfTTN/8F9bUubNfT6qAdKz76quhlpDydwQk7s7u6XZ/CwgU8/+zlm3ITC7oZXvQqEpk7nBGXt0AtxYYH3VQuN3GBwL4e2TZHNRLJ34izBUo5wwvbDAGAzpfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUGNjQ666r4BsIJIniUKiM5v39nRx149/s/osbac260=;
 b=ZM+5MkGH8pe7hY72B0sIAuwGCFjMw1utDVFK3ZbxWcX9V1mGJyMssdbldNtElPRH/O0eMusslBcFEFI7hNvNGO7k4WxI2fAUGxoPVsM+OLRX4TvpbTqbw/zY0+BrBPkBBAIHv3WmZGT5KJmnwWFYwAhwD9CAMVQGYaZgIkTatbsODndZ/awGgJ86xLiFmA+0oo54rxmNaeLJApfa5LpC7AtWqAnT85izrgdYM0c/4lSTvsLTyXzh8NJJrk3Hc2agOPeQPwHYvTIqe/lABDvlIwM/8DOtNbojCwFNaWeZxK7u+18EC+0do+/BR6GVa6ZAhN2XnnEQaPNxPpD9zeCtzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3963.apcprd06.prod.outlook.com (2603:1096:4:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 07:16:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::7969:5a45:8509:7d80]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::7969:5a45:8509:7d80%5]) with mapi id 15.20.5944.018; Fri, 30 Dec 2022
 07:16:00 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     ebiggers@kernel.org
Cc:     bagasdotme@gmail.com, chao@kernel.org, jaegeuk@kernel.org,
        jeff.chua.linux@gmail.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        regressions@lists.linux.dev, torvalds@linux-foundation.org
Subject: Re: Fwd: f2fs write error Linux v6.2
Date:   Fri, 30 Dec 2022 15:15:51 +0800
Message-Id: <20221230071551.61833-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Y66Hk6waTeXQDz1/@sol.localdomain>
References: <Y66Hk6waTeXQDz1/@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB3963:EE_
X-MS-Office365-Filtering-Correlation-Id: 073477bb-044d-4416-3003-08daea35b3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfW5oExTavigjs8MN1KJbOydQo/tdjcqEWS6MpW5mWAMW/QFHJzBHtcF9W71bQsSTA34fQvkr9xNes9RTpzwN+tub8iaK9CXtrDmSGe1OAeECnY+bAY5dlx+n556wLuZ1acEyGHdnZTIffaZV3O64UVyofwyhQVy0jApQPrXS5c6n8hJqR9BMwsFZWPDVwYxOLwDoUeaz7ib6eZu72x26AJhXJlhIssaQfiW9Ms7kWgNI/HL2fIhBaPxsIxFVGN7Nhol2BW8SOQl6dgD4TXF2bBDHozKQ99QNfOySk6xeSTy+Fr6JU7XQPffrMA6Uv4Pw8V5LT+BLzVG7rlQRvIdYR8coepKJbEfKqM1THLgvWfNQb13pJ+/lwFQehrBHpgUNYmk6zTxpbBWXnRZ8G2DIHfEzKkLfatsG/FLjYPu5Z89JlfLHrkP5kQWYFr4Yo/e1LikQZWgiS0Qp2YtQwXcPfDxHF0vceXAycRGswW0hUV3XpFJvshgPcS6vKlxJJjoSj189PlAl5vEfhmtagZ61KIvbELV/5VviU/SYQl+YrUwR+8kRwhUMl47uxFAeDncl65P2LgKB8BM4fiNS8ftiqSCWU87aIMERoO3sYaXBeYVFQZry6+/mhlNb7nrsBMzT7TVH4xHWCs0/ZRQOO+xxDfiAF86P47tDZ6nq2Fh0hPeCDl2Vrfs1rHFPq2saFp8kMo2sy68dzUpOkykR1WoqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199015)(66946007)(6512007)(5660300002)(66556008)(4326008)(66476007)(8676002)(4744005)(41300700001)(7416002)(8936002)(26005)(186003)(2616005)(36756003)(52116002)(6916009)(2906002)(478600001)(6486002)(316002)(86362001)(6666004)(1076003)(6506007)(38350700002)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bS9CM0d5YkwwNHBLem8vdGFNTzMwYitneGdSQ21zdlU2WFNrNnlKWGVIRHla?=
 =?utf-8?B?amFpVURKOEJvemg4dzdYd1M5RHI2MFpubG0vc085NVhBU2RjVC8remVOMm9D?=
 =?utf-8?B?Um1uVmxiUTNna0xDV3JFd0ZXemI0aW8yUmZ1Zkg1UmUyTndtTWlHeG1YVHpm?=
 =?utf-8?B?bklTbVI1dXFkZndTOGNkdmlFMU5yOEVMb0YyRGt2bStab2xkKys1MnRmQjZV?=
 =?utf-8?B?QTV5VTBTU2ZiQ0dUa0twcjZLVi9qeW1JN3IwLzY0d01PL3Nqb2VWU2JQcHlk?=
 =?utf-8?B?VXdNcXdGOVlESTZwSFdmY2c4c1NHdTNLS1g0Q3hGS084QXFrQ2RuaVpEMitr?=
 =?utf-8?B?UjVodmc2N3dMK0dORWdIcEJLVFNvUmtLbXAzWGtIVzY2WTVrMEp4WEtnZmV3?=
 =?utf-8?B?T05nUThkS0hkSDl4Mzc3Nm1yNnVZQUdEemtkL1RIWmpBOFFZNWRtMERGcllG?=
 =?utf-8?B?czloNXR2and2bzRwY2U4dG5LemxhN29iV3FyaWt4UmE3bjg2Z3dmU2NJK2cr?=
 =?utf-8?B?WVNRRFJWcGxRR2NNSHJmVEtDSlhjdEFCeWNFQk9IY3hWaWo2bWRxYjhqbmxD?=
 =?utf-8?B?OHpYVUVGdllsT2w0dGhpTVpZMkxpci9nRW5aVEhnZU52bFZ5S0ppSDNpaVBj?=
 =?utf-8?B?VTlDWU0xZkY0VytZUUo2UEdNdWl1czB2Vng0bVlTb1E4dnZ1VjcwY0U3cVps?=
 =?utf-8?B?TTVBZXdjUVpoYkhDNzF0QXNsRTJ3emVlQTlGak1KQjRUa0JyRTQ0dzZLWHph?=
 =?utf-8?B?UWFGMmNQd0dMZTJHaXFDTEEzNm94TEd2aDV2N25wdzNHcUNJU203Zm5SMXEv?=
 =?utf-8?B?TENJWW4rY3hyaVJUdEVPUGI1V1FpQ1dxd05jc1VQRGJEaVEweUllUU5nUmxL?=
 =?utf-8?B?QVRrdDlsalRuNHdZVUZMM0VSTE5BOWZxdzRkbDJSaDZQSmJJQkkvZXltbVZw?=
 =?utf-8?B?bStkeW93QVVGZXViU2JUOHlhWlhQZURQZlJXaEUvdWZKREcrZ25JeUliekp0?=
 =?utf-8?B?cUdVVGpjRml3aGd1VzM5d3RvbzV4c1lEYzkwaGNLbVl1d1NoS2tuY0Q3ZEQ4?=
 =?utf-8?B?d2lyY2t4OTF3VE1vdTlqenY5YkV4bkVwdUpKTzVJQUZOM2Q4Q0x1Nk5pejFC?=
 =?utf-8?B?TVlPRkZuejk5R2xGc1g2Mzg3WitJeHVkd0dVTk4xbk0xcjMzZS9CWndIU1g0?=
 =?utf-8?B?cUk1elgzekpFSkpnSFZiTGFBOUI4QTRlUEd1M3N6TTRPYk82U0hBQ3dFejJU?=
 =?utf-8?B?Nm1jTmIwNTA4dllMaUVjNUNmZjlNNEVpMEVPelFmTVcycmx1WDhqY1lzdzhU?=
 =?utf-8?B?QlVmZ25CVlhaRlhMelhBRHMxcFRZN1kxK2x2aTBrbXpjWU9RSU5WamdROXNa?=
 =?utf-8?B?Q1hldytYWEw1WmZzMEwrWWloUjJ6Z2VGTFczdmx3WEpidVphRlcyMGxlTGV4?=
 =?utf-8?B?dlpYc3p5dWFlMjdFZlNIaGxWc05SM3JXakRCcjNSTm92T1pJZ3J2NzZWbGpL?=
 =?utf-8?B?OFI5bnREOWFKakZ1ZTFZV2JHNHRGdVBlVkVmSEtTY2JjbGdTdk5NbmR3a3d5?=
 =?utf-8?B?RXlrNWdpU1pLbEJjc04wRHlsSjIvSUV6RUpZWG4wTzAzV2VwNk1abDdxUGoz?=
 =?utf-8?B?ZFB1N09EUGZ4ZStpMENIK2JxemRPa0gvYW5yQUZrdTh5c2NVeE1mTGVUZkdX?=
 =?utf-8?B?dXhJVEt3WkN2REJCc2I0Vnd2ZmRNY2JCQUJLSXRud01VZFBIRlBkd3d4dDRJ?=
 =?utf-8?B?VXh4bS95RHRaamFJa3JPWmRUbC9LOExDbWFnSWFrcFZBZ2xyVFJaV25wR1JY?=
 =?utf-8?B?Z2s2b3Z1enByczdqYUk2SVgrUVVIRDZyNXZvZ1Zobm1kbE0vN1ZtMkJZMmdB?=
 =?utf-8?B?SEMvRlZVb3Z1bG9oVjJyLzEvbmc0cmtrVXJWRVlRSEZGRzdxdHNmbklSTkVu?=
 =?utf-8?B?Nlg2ck9aenlLYnRtS20rRXhtdWhQVXJCUUtBU2V4alZsZUtUZlMwQys4L1Y4?=
 =?utf-8?B?YWlXamZvU2JiRytyckhZV1g3akRaVHBTdDRkT3lMY2poSDdObTcvNTJRWllv?=
 =?utf-8?B?VExKdmRyeHlrRWpRa29DMXg3dlZtcmxNZ1hTZkRodG1tS1NHLytKT1FTd1h5?=
 =?utf-8?Q?UzdfBCbFqBEuSIeCQDRn0/XyZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073477bb-044d-4416-3003-08daea35b3f3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2022 07:16:00.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVn+UphOpgn2jCvZbv85pABF+3Twq+sid/pWudhv7SSqRycM0C92pLS7vFqnjvNeuRdMGPs7RWpPMgI8l336xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What happened to the f2fs developers? No response from anyone yet. Am
> I the only one facing this? Linux-6.2 is unusable until this is fixed.
> What can I do to help?

It's been a long time since I saw Kim and Chao respond to messages. I think
it may be because of the holiday in the US，and China loosened restrictions
on COVID-19 (lots of people got sick, I just recovered today).

BTW, the log you uploaded corresponds to which kernel git is, and which
commit it corresponds to.

Thx,
Yangtao
