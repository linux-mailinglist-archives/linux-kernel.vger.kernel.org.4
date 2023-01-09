Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15336620DD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbjAIJCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbjAIJBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:01:33 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32E365E9;
        Mon,  9 Jan 2023 00:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673254517; x=1704790517;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C/Bh4XDxN6RZla5inb4p0O06GmZqpvUo90j9dgrLQiI=;
  b=b0UHdiyXG+STLOX5by+JrnIAbGiIO0jhW/e7Y+RxSMpMw5/cLNENpwRP
   WGHgZXEaHnw8douh2aabb2BAWP/5v9fNh0oFSIwGrF9GpcJZuL1reBdSJ
   OLcbCkeolRP74KCHUNll/A3pWlwSNWIH2bMxLRAYAnWFVVduXuzo/eXwJ
   VipVR5Up2RCLWUfoM/2tUSwxAmFefApKGSFIgIFnS3KWaYIV3LdyOdP9K
   c7wVGDvO+HbGXGgzjf2traaVMZFGL8hWDp8Zy9gXRjmdYKRQ3lb9PaFbb
   E2vvKqQwdC2GCiyzi5Qo2FEzziRPPL3wId5IeokpO4ldrk7SKg3ZJlLc6
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,311,1665417600"; 
   d="scan'208";a="218618577"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2023 16:55:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxZrvbOYtlWirJM1DZZfVUfeBjv9LZ/Xz60Oq+CVv/Wb/moW7SAMQ/QkOA4qeeu1B9PIyDdLW8htTbI2wmPmIsQqGffFfQKT2kU8UFxdSDpKU8UJnjZR8Vyo4Qh+b6aP/sCVxp3xj7ZK8HSINMRS0rev7JkOZWeRrHJM8BcDbg/xylLVvmkZ6aS+yRPG3cpmP2sbGP1dNiD0PEZQgaF5TaJ25R5oIOMyN+DgpmVTPH8FfAxAAq0cRXz2ygQV9ReGhXPAupUVW5oFgINDz1v80Ze9qrKlvyntPGpI9ts0EWeBIBPOW0P17GBpCsXcXtbRL//4lqdWzM6Huspr8sK5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/Bh4XDxN6RZla5inb4p0O06GmZqpvUo90j9dgrLQiI=;
 b=MYqhaOg/kzERbjWSEkPchpbRf05A8wYJKYrBYVoKMH1alJttxh/J8se0q0gG7jIJ+XrmqZgvarlytSsDHfL/J/107mD12YzPkrR7QFza9z+hp6iDzJHBnZpWMSOzSnaEgdSP/GDDAk1Pf7ddC+qoYJH96scoMNPlto0hdtwAnuHZE6NLsmpt3NF1wmnwRCodabUx4EuZC6h1olgGDKvLAzqMlEzIXjUcCLuW3jQ9gO921/BpB+C9IIxgbZxDfLWrDIIFjYpxCUl8pLXKyaUo4n85hApelKZ11uUGuKVX0buujBSb+ZJ/4WUm5Y2coHY1+T0nPRUuleaW0EQ2DcKk6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/Bh4XDxN6RZla5inb4p0O06GmZqpvUo90j9dgrLQiI=;
 b=M6ZIKLaoxEDpqlKUva9ycauL/UeHcriFqYpUOHEJOIdudtsWH3x1fK3q3wnUN+SrOhKwfrjpHEU7qoXOyuZQw/opzfhtOrTPK44NANsDYW3F+9XGVNPgY1NosLPv44JnTFgfY1q/XIs0p8ts7Ii5sgr7NeHtDcq47hxD8WZbGsE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB7971.namprd04.prod.outlook.com (2603:10b6:610:f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 08:55:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%3]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 08:55:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "kernel@pankajraghav.com" <kernel@pankajraghav.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH 1/7] block: remove superfluous check for request queue in
 bdev_is_zoned
Thread-Topic: [PATCH 1/7] block: remove superfluous check for request queue in
 bdev_is_zoned
Thread-Index: AQHZIamszurSCek3k0urRtU5la86Ia6VzNcA
Date:   Mon, 9 Jan 2023 08:55:12 +0000
Message-ID: <be10834d-4c25-d9bb-d942-445f60174159@wdc.com>
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083319eucas1p1e58f4ab0d3ff59a328a2da2922d76038@eucas1p1.samsung.com>
 <20230106083317.93938-2-p.raghav@samsung.com>
In-Reply-To: <20230106083317.93938-2-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB7971:EE_
x-ms-office365-filtering-correlation-id: 89e26737-e324-4e43-c841-08daf21f3867
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EWaqfbXaQ3ME0syttvqV0sxMZLNhGzFBTnb96DyhTIOxWX0kqd/YMc/kKVf9whO+UOvwytvMUD3z4wOkOgbuNQ91xHk1XPztJMZiFW3iUuObiFYugPYkj+q3LSHFfNKyZx+OkY8wW7Bd69AIZ5pF8KgozhQOu+12BqhWjxvdN/m+WMXwIyk/M0XuMMnVCsdgj8NImjcVUBEi18gRf9UNhBGdJ+GWGuu7PvLLuMInXFWR+1CLDXcY9ZD4NUOBhCdkMj3N6E8JWf13sjQCSHXv/Mgc3f99Oi2ITcSF/plO3pXYh0G9OBinGnC/383QtePh20aXEXKM25U114+z5YSYrG6M79xDtoe7g2vF86y/sltOiFaZ8u2maKH//R6jB6roYE4+K83/XHsAEUcEjAx2jy7nc6qXGr0ofnlPB7fIKj6iHlRARFbB1jhQmt6faTkj37EMH1JbyYWQOyJF7C0dnnv/fEKnJojmlVkn/gw58thODBeKUNRcI7EN6Cv7VSUeWD8ktDwXTmwDInYmYZZasKE/4eELO8/q81bFFvTx0OgfUP8iQ5Dx3qRc19nUrDz2f+8Sll77vr/+Dp0ixpauzhDdylYGEq9tRuhEhFVfoZAbwabd2bhq3Qh6t7qT56LDoXUEjbxpBx3KfMP7SZmjsE9xqiQu1g4Pfvyp6T+wQ+NQTaJQ9Q0pjPuqpx1KUvAQu4IZHtLmCdO69QsAZoi7SpTx+LtOK2vKqo78t1YpEW4BtDfZYQdkbfptexkPt2jnLgfs+Nk8ms3bN+Yfg2D1LQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(36756003)(186003)(53546011)(8936002)(122000001)(6506007)(6512007)(2616005)(110136005)(54906003)(5660300002)(66946007)(7416002)(66446008)(66476007)(66556008)(64756008)(4326008)(91956017)(316002)(86362001)(38070700005)(31696002)(71200400001)(6486002)(38100700002)(76116006)(478600001)(82960400001)(41300700001)(31686004)(8676002)(558084003)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjFPcmxDTzEyRHZncCtiN3pZVXJ3cTNPWGxQcHV5N1dEdVlDUElyeWZSdWRN?=
 =?utf-8?B?S1pPUzhGK2NzMWNkVXFXR0NZZmZyUXVmUFYyMVBUL0ZWc1BrR0k5WlV0VFJp?=
 =?utf-8?B?Sy9ITG5STlFHenV6cDF2Z0M4Q2RNajg0b1N6bkEvNjNQOWlmYk51bXIrZzJv?=
 =?utf-8?B?Rzh6MjR6WTJPUjZJUUlpb3lYL2d5R01pRnhiQUd1d21MRXhOa1RySVBZRkYw?=
 =?utf-8?B?OW16djZvTUFPWnFISjhHaUdDL3BkVmZQNjRrdkcyeE1tTW5jZWF0RkVEa2ds?=
 =?utf-8?B?K0lSVHdySldiWUtzWUt3Y0lUMW9aNWF2YTcwbzFjOUFzc1M0VG16MWtqVG8y?=
 =?utf-8?B?VE9DOHR2c2lWUndMSzVDZlZDbGQvVEZMa2h5OWxTRE9jZXRVRzB0Ry9UTHVu?=
 =?utf-8?B?M2pkaldLZnhuSWltOVJRSXluOEJRSFdXVUEzQXphQThodmhQRjBiVHpXNjM2?=
 =?utf-8?B?N0x3WUJkd3MyU1RMWkhMamd0aElOVzVPc2NVbkFVZmV3cE5iUE9FeEZzTTBz?=
 =?utf-8?B?NnYzN1llMFlxUGJjQlpNTE4vMENBMUE5c3I0T2x5TEVYd1hIR0liRUdOQTRB?=
 =?utf-8?B?K2F3SnIxRTdPbjRYcThpRExIa2s1a1hNOWZGWURONzNKVlpNaW93MVo4bFRQ?=
 =?utf-8?B?ZnZ5NURTclBJN0xZNEV3QWJGOTVmUzBZUStKOU15U00yb1kzQ0hDWkh5TEdO?=
 =?utf-8?B?S01NT1J6UWphZzVqekZSZlZROFQ0YzlwVGVrTkhOVHFpSUpYSnB5eU0rZHB0?=
 =?utf-8?B?clFNcUw0c2I2Um1Zb00rL0hmek5GTWF0Y01rakY0Yk0vWGY3c3FrSFFNbCtn?=
 =?utf-8?B?VnVncFIvZ0dRayswYlpPbjBNT0NUYXVPTkFQOUtsczBYcnJvak02ZnhFbERt?=
 =?utf-8?B?WkZDMGRtVDVXdEthanFPRWpZMnIwSzNaOUJSZ0VDU09sb2tHb01UdG9pZ2JN?=
 =?utf-8?B?VjJGMFd3UGRDWGpYNlA3MFNGdHlYOExYVmFUaUdwT2pXaEFoUWM0OE5kd1BV?=
 =?utf-8?B?azRZUzJOQk9ScXBjZjJqbWEreDNBdkZWbFBIc3hBbElPdWkrQ2lyMVJRWm5i?=
 =?utf-8?B?QmtoNmhZRVErWTQzOGU0Y2VQb2NmS0YwT0dnL2hOYWoxZlFRY0NBQitKU1VE?=
 =?utf-8?B?YmZFc3gxelQ4L3Z1QWVTcHZTOGJtRld5VWpqaVE2MmxWMm44VlJjK29oNUhZ?=
 =?utf-8?B?NG9jYXNUUEdIOWxIRGM5UG1tT3VmZTNhSkE1MEdCYjRBcjVZa0p2QkRRaWsr?=
 =?utf-8?B?Ylpnc3plRmtyWUlRSnhzV3FONkl4b055R0xnVnBRaHEvdm1lRy9zVkhwVHdD?=
 =?utf-8?B?cVhaNVhvTmxnQXBoMU9PMnI3RVdFZktiZ1Z0ajBQVEw2bkZoMWxzQzBTaTJ0?=
 =?utf-8?B?M0RaUmN5aFdaTFoySk1CakJsaEJiaiszcVNGWkQ5TEduUE93aUlTRHFCb2xU?=
 =?utf-8?B?MmJwZ1YrNng0MFIzZXc1QTZ1aWNEUmp3Y2Z2QlNPanJ4Yy95QWphUWtTRXJw?=
 =?utf-8?B?ZDRldDJrOVNzSVl1dk51eFlsd0ZsSHFHSTJ5UDBtR0VhMnYxU2xQTy8zQklN?=
 =?utf-8?B?WGVBaEloOTIrSm5ZcEpWcFZqbVB0aURxOXA1c2xidmZCSDMvMndnQm1YTTRT?=
 =?utf-8?B?WUszWEdUQ1VDTHVyUkpEd05HMXFReEdhd1YvejJFTk5Td0J4RSswWnNMNFow?=
 =?utf-8?B?UlJ5V0JRVXpOUURRUE5QUXJRR2NtbkNLc3UvSzhydWQ2cVUyUlpGQVZZSWt0?=
 =?utf-8?B?NmJlR29NQWtQY3NHNllucWtIZHg4MWY3WEFOWGRGendxckM5SEZCVzIxTUdZ?=
 =?utf-8?B?WjYrREI1cWdhV1B1MjRjNkxrcDNvVkIxZzJ2SnZaY0ViMzNDSnJkMjFQSTNr?=
 =?utf-8?B?TTl3aHFtMDNwblZpOXlpdG9UcGM1WlRqd1VaZVpTRk1saFNCMnZFb29tN0FG?=
 =?utf-8?B?ZDNFSlorVFVKenYwMEE3dzhJODdrV2dVd1BFdzdmKzdRU3B3MnR2L3NNblhE?=
 =?utf-8?B?aUtuMm9WaDdxdXV6WjlBUUN2bjNabFhWeG5nTVBtNy80dXNybUphM2VJWUNu?=
 =?utf-8?B?aHZrV0xzVGhFc1BFZEgwdkNmU0Rmdm5NNVI1akdRc1JjMzlZZkE0SjlYOFhF?=
 =?utf-8?B?d3VLYXVyOUE0RFJYc3hEWWZhdFRMb1AyclBqUXh5ZXkvR2NFeUZLV2Z6VUVF?=
 =?utf-8?B?L1FaMU9IMWs0SXVGZGZDTHhTUzJCZUdpRzVpZWZBZE9FKzltTDBhT1YvamEw?=
 =?utf-8?Q?5HdvZXL1utT54LL1Gcx4Qr98haz7v3K6rSqeV7ZYDc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <793D456AC31B2542B08285BEC0A9F7E2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OUlzMHZtWWR4Q3Y1T0k1RC8ralVMZDEzQ3F4bzhjVnU2dHd3bXAxK3lrRTRz?=
 =?utf-8?B?NGR4UjJBVk5NemhxMWNJVTMrUFYrYTFGN1RrQTZ1ckVWbnpwQjNoZzY1ejdK?=
 =?utf-8?B?UXlOTGZBM1pRaUwrK05WQXp0bzY0VGQwa1hYa2cwckhmR040RHg5aW1UaHlG?=
 =?utf-8?B?NkxWZ3lZREJsRksvVnhXZjNUMHhLT2cyQlRKcEhVd0ljcFloQ21tZWhzN1E1?=
 =?utf-8?B?MFk0UmdmRXlyeXhiQ1loRC9YK3lGcVJxdWRUMzc0U2hCdDh2b1J4R3FRUWs4?=
 =?utf-8?B?NGJvcnJYTHNEVi92ZHkzQmcvcGYzdVZ2b09UV0FYTUJjYzZjWHRHeXoyUDJU?=
 =?utf-8?B?aWd2V3pPL20wWVFJcXRYTTNFR0dGUHVWMDVmN1dKdXlvRmhxOEpqWDVrbE9G?=
 =?utf-8?B?WnlGQ3k4YUV3ZG9SV3k3QWVoTXVIUzlxLzhsYTZLVVNtNEZGUi9OZXZSNG1K?=
 =?utf-8?B?b29LdFVNaFo1UUVPbVgyWjhqc05qZjR3SllIYlhTdFZ3NTJ3UlEvRGFnc2pN?=
 =?utf-8?B?ZCszTXZlNnNMaURiMjA0V2Zva2hVVHNPcmRMZGZkK2J1cHU1TmlPOFUyVXUw?=
 =?utf-8?B?djNNeTcrcUg5UGNqRjF6aUtDMDJod21DV2xtWDlLR3o4b3ExMDlwQlg2Smd1?=
 =?utf-8?B?dGZIR3JmTG5nZ3E4TkQraTNxSm5Ld3hZZmlVd3hRdUE5eUY4V2gvQ1lKc3pk?=
 =?utf-8?B?dSs1ME9OdUlIbGxJL0RLOU5VZUtOZiszZGFtcFZqL1grSWVycUl4V2tVbkNs?=
 =?utf-8?B?ZHl6OFhGU0NoTlBXR1hXMll5UFhPaVgvRWtVTUpEMy9HbnNWMkhabGJTajBG?=
 =?utf-8?B?UlRObFR0VHI2TW9uMkUyMERacmJtTmpvaGt0bU9iOFQ3K3JreDZNc1l6Mi9E?=
 =?utf-8?B?MnRlS1NQbGwveXFockFwb3Zabk96MWFTNHg2M1BOTkZoMVZHekJMbjR6VmhS?=
 =?utf-8?B?eGFSYncxY1kvREpmSkFOY01lUC9GWDlHdkdrZE5WcmpBM2ppeVBiRW05cE5T?=
 =?utf-8?B?ZVZYZC9ON2psaTI4WkMySEk0Q1ZnVHM4OUVkeU4vK0xNWVBKc2F0UStRT3Y0?=
 =?utf-8?B?S0pBeTdJaWJ1OFBnZ1E3ZVRnem51SzFydFJxUks5VHNhdDlIUG9KSEI0N2Nq?=
 =?utf-8?B?WWN2RnNyRTZNSy85WW01MEVtalZkMnJLVEZVR0lYMmZGaGVjZ0trZ2FvenNE?=
 =?utf-8?B?RWRPWEt3SFdFMm9oRk10RjhRZFhmaWZyN2VETnY4L2RDMCtRWGJ1NWl6YjFT?=
 =?utf-8?B?clpiQlVYT2w1YjNPTVV5dHFoWWp4aTdITUNJcWRNKzRLSlg0Wk4zNkJhRWVR?=
 =?utf-8?B?T044YlJPV2RuVmtwclVhRkZXZXY1SzRrNWxXL0RiMkJQSkZINFAvNzhTcHBk?=
 =?utf-8?Q?45+Wah/VEUmwkWTsMbB6BkhF3/l/Yqt4=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e26737-e324-4e43-c841-08daf21f3867
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 08:55:12.9954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Xx/hNI4CaeZJil//725KbEzXuABiBtxz+z1Xoz1wXEAnKxrvAbsnExFHUj0qIQywCpmbC7+77qqiDKXg2tqEDuAB8OoFerb5aSVnMKkN2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7971
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYuMDEuMjMgMDk6MzQsIFBhbmthaiBSYWdoYXYgd3JvdGU6DQo+IFJlbW92ZSB0aGUgc3Vw
ZXJmbHVvdXMgcmVxdWVzdCBxdWV1ZSBjaGVjayBpbiBiZGV2X2lzX3pvbmVkKCkgYXMgdGhlDQoN
Cm1pbnVzIHRoZSBsYXN0ICd0aGUnDQoNCkxvb2tzIGdvb2QsDQpSZXZpZXdlZC1ieTogSm9oYW5u
ZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==
