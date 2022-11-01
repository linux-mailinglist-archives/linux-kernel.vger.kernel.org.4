Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441D8614DF3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiKAPL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiKAPLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:11:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9031A230;
        Tue,  1 Nov 2022 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667315070; x=1698851070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1TnlZOAumZCUqTAsP3fCwCfZ6AxfD1MlcugFkfDghyU=;
  b=SIRpWaur+GhwGhctmKe0zgpwGoowZjc+BjmqwXFrZXOwaUccGJX6wBt2
   nO87nGE3fasDInkRXXsCj6mCXZOtSZ4X065NzxGDJHPPJd7mguHQzY5Lh
   BL3n7bBVIUfqzoR777bk7ka5B8JenZkPHOqCKXcuRBLGrHN5QzdlvT0Wl
   ckCOtryUpQnJqroexxKW3L4/MfzriNNOpJyKHZFWS3WzuBqPj7x1Q8+X9
   fclVNFun5111j/4qa8DuGKY4tqjTALr/zH4WvpWqZj/fkRNkZSKWh5AOG
   IGAund+BwhWjxoje/Xlv3uOh+4YLBhO8EhJZFHkj86Pkm8GePm3I3MBQm
   g==;
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="197920257"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Nov 2022 08:04:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 1 Nov 2022 08:04:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 1 Nov 2022 08:04:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E394gTFbs6jTG0rW3oU8mbId6iAUtYDLFuO3SHotNVM2d4tAlTVsh0eRTMI/2JvsHGYyPyO4KAiBuL2VUK4/dmCpI7IaIsqiBNvKvOaQWQzgfzH2JLj4Bfuk8Wg4jzusUcHmshnED6PudIvi26Zs9iE6VuufdzEEwWQUiTTgrmNkRyvdUzS9jrxTWt89rYtP4Ia6oP5wt4OnCSZatWSikJPco9M5pdyeV8L9QJnvax1Q1YD+r+oQ/Ax57bwfy1gZIegykyDc2He3xcMxl0UkewUaDgMNvtrckt2iqnAuyjsVVDyoCP4obuhRZpdOdhc+F/HtcbUsDhIDg0BJz8jw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TnlZOAumZCUqTAsP3fCwCfZ6AxfD1MlcugFkfDghyU=;
 b=Xu/xcgvqyfzZ+Bd/cKoUwM0zwr07PDcEmr5xd4QEPqOQxCRIT5an1KRzzHIQDRaw/2WIMBq12bu6N6oJTS6RN/rNhIZJW5l01B/HPJF1JC92CA2E0BDMKn2phVahciTvhhSZ3HHFKEtpNVGsMGJgXb60HJX+Bqb80fYjqGAy0nZyfFeLAJGD/K3iqFWgRlhuORXThC0BIwdoSUfqOhBlUNMQU79oxxGbx1h7cY/RA76JzH7egd318fxjpCp0rJrk4qqdBZKZqccqEoylx+L89UY5lbm49Cr4SEmTv1+i9o3iY7sJ13WuuJeUtkKqtD09o/I8ZoDAFWgfTXl0cHEolw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TnlZOAumZCUqTAsP3fCwCfZ6AxfD1MlcugFkfDghyU=;
 b=cvmoqzB/U6BT1RtZz7FNr6sWwQ6fGnTIlkCNq8XKAGHI2Edto0wZaZ9NItRYneFiszzSfYq4WU8VUys2mQ2MQvalbnCmEZvXPObeK8+nDebiKoRDbEjwIiB7AFdMYjJNFSP75PmyArhJDFTuje0F0A8MiOfZVsbFtEq8uLJ6vmc=
Received: from PH0PR11MB5096.namprd11.prod.outlook.com (2603:10b6:510:3c::5)
 by DM4PR11MB5502.namprd11.prod.outlook.com (2603:10b6:5:39e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 15:04:20 +0000
Received: from PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::1cfb:5030:3f7c:7add]) by PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::1cfb:5030:3f7c:7add%9]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 15:04:20 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <andy.shevchenko@gmail.com>
CC:     <Kumaravel.Thiagarajan@microchip.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <u.kleine-koenig@pengutronix.de>,
        <johan@kernel.org>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <macro@orcam.me.uk>,
        <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v2 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver for
 quad-uart support.
Thread-Topic: [PATCH v2 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver
 for quad-uart support.
Thread-Index: AQHY1V1ECgbqKV8AiUiKZBGdoHOFW638aLWAgCwAOWCAAFjnAIABmVjg
Date:   Tue, 1 Nov 2022 15:04:20 +0000
Message-ID: <PH0PR11MB509684CE1142854777FAD9979B369@PH0PR11MB5096.namprd11.prod.outlook.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
 <20221001061507.3508603-2-kumaravel.thiagarajan@microchip.com>
 <CAHp75VfoWii5Eo4n=-JcqE4VZMRoq77jjdTMGfwBF+vzKBXPog@mail.gmail.com>
 <PH0PR11MB509629C9B80D4331AAF0E5AC9B379@PH0PR11MB5096.namprd11.prod.outlook.com>
 <CAHp75Vf5sBJiNQckCxDGCzFWBYnVs4BhP9+m77_6guZYC+Cybg@mail.gmail.com>
In-Reply-To: <CAHp75Vf5sBJiNQckCxDGCzFWBYnVs4BhP9+m77_6guZYC+Cybg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5096:EE_|DM4PR11MB5502:EE_
x-ms-office365-filtering-correlation-id: 42482f44-f9dc-426f-8405-08dabc1a5ab9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cFVoDmB/kBKkwfD7gpDgl7zX5stYCbOAjageXf/8N/fgiGfbDD/d4+SxXJMlVoV4ugAagesqfhg8HoFey7JJ0Id1ftnzRE+zcdBKa2+On7DZOJZlTrtnDbgjmh4VOyMCyJjTm+YfR9HxGijXHm7jzxd3DVX9XVu3VUffyd7+pkcyxC8G5W1qdGX71wsvsnSXqMRa6uFx96p5NxWxjw8YmH+ZKMpvMwD8Ja0igiwCKab0w1xkKFosRzcivfc0v6OMJz8cU8lmBXbkl0p0dHglpEKAke9HER9y9biI6dqldsQ1p/mXJfAl0pSYIJoaEqxts45lu0xEdUZd4dgL5GzRp9eaZui/DuV++BVyANaBod4g0qDh+/R+5FiolxnAiU2zhxv7jDsOdOWrYqkidJE+cxDmyTS1Seoy6pSyywUWRUClHlJIbibzx1KQAtMT10Zo78gEFGPMJO1ApJ3YlKBJAumZOxy0ralGeyjnDH8vVTCRPMo7pBwqcHFZKb/djOXzZs668lV5puS9utSrjxWq+3GgIE+rlRHIcwKbGnel6MN75O91gTiMRiFtFAIEM/rBNW5Sx9wga7Ql8rf+DonWcZdA9TaSgTAWJWFt8qXtSfJmUgHY/55N1d7adQ8KJVx0b+BFGRqlwdNrf7OB1HjGKeDxrNgcDRrD1f4Oyo7TSehw9WmvtnL5vcbJNJPsF7duvGXKpFUuR4yp6WFKGMSnT9ANXT3uRJ8pD//0FVhTDbV/Vb1S0lVBHaRQieTAkfBNlCyH7X50EiPdaBJUqrwh9oA4p84vAdMmAUW91t48XZVTt3rGxQMIKrmKpFK6KPAa+vbrspnCX4WA9rnH7hNOTTRr4TedpGF8LvXbNe3iwfI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199015)(71200400001)(478600001)(53546011)(66476007)(66556008)(7696005)(66946007)(8676002)(66446008)(64756008)(4326008)(6506007)(76116006)(2906002)(186003)(9686003)(7416002)(52536014)(8936002)(4744005)(26005)(5660300002)(41300700001)(86362001)(33656002)(83380400001)(38070700005)(6916009)(54906003)(316002)(107886003)(55016003)(38100700002)(122000001)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXJkemNielJxNllOSHpvNWNtb0hjQWthWFZ4VDNTUFRYeEoreUhiU29vMnAy?=
 =?utf-8?B?ZzIzeTlNcDdmYTBLcHZ4c3ZFa0NkdmlTWDlETkJEQnJWN2kwUzc2bHlEQkp0?=
 =?utf-8?B?NHh5UE93YTI4SkRjaVFmUnlXcytMcC9CTDg2QVYzYmZJaWhaUHpxZXloZTY0?=
 =?utf-8?B?NW5nVlNJSThVYkZsL1k3dEpMUFNTblpFQUgwbVI3dzY2ZktBMzU2cUxreDJ2?=
 =?utf-8?B?T3hMWHBCRWRtNk1TblBteWliZ3dsWGRMMWxndVA2dGdTamNTU2RteHI2dU1r?=
 =?utf-8?B?YUZrN0NFdmxhclJRZUUrREZ1ZEowaGpoU2tXaExkOGtiKzZEOWF0WWk4bFk0?=
 =?utf-8?B?RXJWQnBXSUxIV2p2ZXpmeGhQZEpHVmtNRnZIT3kxcmYzN002M0M0TGkzRWpj?=
 =?utf-8?B?TzI1WHNqdnF3UVJBcWJrYi9KR0t0NkZWTUJPaW5JMEx5amF1eTZ0aUhCU0Jm?=
 =?utf-8?B?cEMxNVAzTmdSZ25tMmVtY3I0SG1iNUJLdkRKN3BFK2QxVnU5QjVhN3Z5ODhX?=
 =?utf-8?B?RnhQa0lGVmFWNXhGUEp3bEZuNGRTL3BFTnFlQVNWaWRON05jTEdmcnNOWS82?=
 =?utf-8?B?aUg1dWRodjJub0JmS1FHQTk1ellSb0pjNElGMGc1UW91Ui8yWUM2VStjbjky?=
 =?utf-8?B?aFJ3QU5hNEQ2MUVURXQvcjd3MHIxUmNxNk9kemNyOU9keHdqUE5pU09jQ3dl?=
 =?utf-8?B?QWhJZE53SHVCRWFWUXRXR0NSeUU2WHdNNWR6SXV3dFd4N2JHSFRjQTh3cUVw?=
 =?utf-8?B?L0RudXE3OUkxTFlXOUVTdTlwVng1QlhsTUFhOEZLN1BqWFRKVzEwVU1nbWZa?=
 =?utf-8?B?U2ZJWUM1cTMvN3B5R3JoN3k0TGRHZTdZZlR3NDFsUk5KMzBpWG9OUVFkUUw0?=
 =?utf-8?B?ZUhwTUZzblNoMkVFQnF3ak8wTkp0QmJ3UTU0M2p2WjEvS2lRdFFqQjcyQ1Na?=
 =?utf-8?B?bzBoaERYa1JrMWpMQzFGeXd5V3NpMzhMWFI1YXgyVUxZZlVXazVaZFg2ZjdJ?=
 =?utf-8?B?MVNtM0lYc3JUelBjZGhDcnVJZk1OeHNsdW15cGxhb0R2RHFNSmZNVi9FaDcv?=
 =?utf-8?B?VC82UHZkZWtoYkFZdDBuVitsVXFuL0NQMkxvbDRyZW1yZVVZcVhWRVdrTTBn?=
 =?utf-8?B?Z3dyZFZORWpoRFNKaDBFTFE4cUE1S2NpdjYwWnBxWlBZa0RqUEFHbTJCV24w?=
 =?utf-8?B?YnYzMklSenF1V1JXcTk0NlNZZjJlTjJhQy8vV0k3czA3R05oY2d2OHU4UVVh?=
 =?utf-8?B?S1hNcVhpbGJ4L2IwNHpTdWlkMmpmSkloVHkwTG1vTUxwcWZBQVA2MDBFY0pD?=
 =?utf-8?B?NjJZVjdtMkxmbDhsZjZoUk1mMWNNR0x4QkJTaUdKK2VQaGgvNUs3bUZIcjI4?=
 =?utf-8?B?SmR5TlhQWGVGMUs0SjBmRE1iWXBjcjNFRVIrMGNUZ1lrVEFlQ24wZXAzSTdn?=
 =?utf-8?B?UUpQdXo5WnI0ay9SRjExTzQwWnJ3bnA2OUc4WTNTVEpVMVNXOXRNTnVibGdE?=
 =?utf-8?B?V2JPczVydHhnNjhldXpmbHo4b2NaWi9yVHRrQUt3cGpQZDcyeExsQjVoekVZ?=
 =?utf-8?B?Y1NTU3JrenNnVUhOenNOeTNqQXgvVTlnWmoybVVqQlVnNE5PTzZlUmtEbE5m?=
 =?utf-8?B?a3RsT0k3TElyTnNyNzVaWkhqR2t1SWdJWmk1VTNmdzROQmFETDJRdkMzSDgv?=
 =?utf-8?B?eEFDTWtOTUoySGlDYVl2N1ExT0g0NnpiNG5YOW5EU1VYalFBVXNFQkdVd2Z3?=
 =?utf-8?B?T1BYclRRUmkycjlGQi9xUmFlMXhrdGNXM0FyZWFNK0p1UFVadlRPSnM1djE1?=
 =?utf-8?B?OW02ZUlnTGhLOUhHSFpPOXkyc21lUFdBZnlpVnZzR0tqTGxUcUdDdHNSdlRt?=
 =?utf-8?B?WEordGRXNWU5RUJzdmplb0w3WnRrOUdSTFdaWEdrdnlmYi9DS1N5TXVJV3p3?=
 =?utf-8?B?N2oxdmNvUnpCVHFRT0hFdUJ5WVc0Ri9hS1M4S3o5OWNId3pzTWtUZWpQV2RQ?=
 =?utf-8?B?NkgrWTRzNisvUXFwZ2JvRGNOVFdMVDBTZEFMeUN3bFdoTHdrNTkySCtpdDNw?=
 =?utf-8?B?Z2FFLzNpR3c0RzZZOENZdS9vTjhKSCszMmF4ZUlyM3c3TkZlQ0lXaXRBL3Bp?=
 =?utf-8?B?YWUxMFlVK0pwSzh4WlJCMllZV0diUWhtUy90SDJmS0gxaEVsQmlSaDVPNTh2?=
 =?utf-8?Q?3biN4l7IYPfcD6pCnPH4oQE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5096.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42482f44-f9dc-426f-8405-08dabc1a5ab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 15:04:20.3469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Rtkp5s6DoBi+i/I+4vzX4M/VOhJE1ruyM/17QIm+Bugl6hriqwUGd/Q8vZGx5e0h0Ic2uhglAPzuc8N1GszMWYYUX4HFHpa585LYyMWlqLf+4tICSgJtTK25cAbFDTP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5502
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNl
bnQ6IE1vbmRheSwgT2N0b2JlciAzMSwgMjAyMiA4OjA3IFBNDQo+IFRvOiBUaGFydW5rdW1hciBQ
YXN1bWFydGhpIC0gSTY3ODIxDQo+IDxUaGFydW5rdW1hci5QYXN1bWFydGhpQG1pY3JvY2hpcC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgdHR5LW5leHQgMS8zXSA4MjUwOiBtaWNyb2No
aXA6IHBjaTF4eHh4OiBBZGQgZHJpdmVyIGZvcg0KPiBxdWFkLXVhcnQgc3VwcG9ydC4NCj4gDQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlDQo+IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gPiBCdXQsIGlmIEkg
ZG8gdGhpcywgSSBjYW5ub3QgdXNlIHN5c2ZzIGludGVyZmFjZSBmb3IgdXBkYXRpbmcgcnhfdHJp
Z19ieXRlcyByaWdodD8NCj4gDQo+IE1heWJlLCBJIGRvbid0IHJlbWVtYmVyIGJ5IGhlYXJ0IHRo
YXQgcGFydCBvZiB0aGUgY29kZS4gQnV0IHdoeSBkbyB5b3UNCj4gbmVlZCB0aGF0IEFCSSBpbiB0
aGUgZmlyc3QgcGxhY2U/DQoNCkJ5IHVzaW5nIHRoZSBzeXNmcyBpbnRlcmZhY2UsIG91ciBkcml2
ZXIgd2lsbCBiZSBhYmxlIHRvIHVwZGF0ZSB0aGUgdHJpZ2dlciBsZXZlbCBmb3IgdGhlIHJlY2Vp
dmVyIGZpZm8gaW50ZXJydXB0IGF0IHJ1bnRpbWUuDQoNClRoYW5rcywNClRoYXJ1biBLdW1hciBQ
DQo=
