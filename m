Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC67712EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbjEZVY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjEZVYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:24:24 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF0B9C;
        Fri, 26 May 2023 14:24:21 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QBYFiA030993;
        Fri, 26 May 2023 16:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=PODMain02222019;
 bh=XuupHnNfEuwBz+pNObSN2yC2efixkE69JEBZRv5CFCA=;
 b=GN/na2zYmDoHbvnfucLgWixqmXYHEBrQ1+xckTtxBOx+aJfSWkMGDNRGcax5hX1H8LbF
 oKVEQOP/pX6Q6Hp6odkMfYeTgBffxOXzLySmvS/MaDlSz6WAyUrK7TAlCpHAx5vPhzeT
 nnxPc3aU6MZQg2txk2GnzhD+KUwQoCJKVl4U2Prs/cVJF0/4IwOgfK02nL1BmvEvO9LM
 teMLiCIvgV1M2H3c07/ZLAC2mPIEqu/xy5av9mRpGZ/ibve1rj6gqPC6yf9gHAfFSYtT
 eunnzWUiIamGrnSLvg3pZnOKDGFWkPL76793jP4d4oksJqxQERDTQDpZj0R4WRmgZz06 8Q== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qptmm93es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 16:24:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHzVoviv/d9J9ZiEDMJOUOpq5eJcwsH4Cdiubx4bUOm6w8lU8uwdT8Fb1HFOVPKRTpc6duvKHtBk8oTM0E6XgJk5CWMyLLLC1nk8DFlPzIETx4O/eCWMQE5r+MoZskjhb/AGiINyrELdL3KZAxGonot0ZQHT/dpWl35Jba4Pl7V+g8aEaRzeks8eFq2FNPaBYlm/oqQy/eA/kByepkY/fCrjS4Izt0VjEB+H7JbJBUpkk+u/7GBUY1W77xvVian6B2p9mIwq7vA0DdoOUr7+bdBf/wzfDMbWvGPNuY3t0LQUomAmxeFbJUaQNyw2NFV8IJ6Mac9xATqSZax29aWLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuupHnNfEuwBz+pNObSN2yC2efixkE69JEBZRv5CFCA=;
 b=UyNVZ/7kN+TIcA0Nqhz0iOcqYnDQ/ZPsFUP8e6IeTjSLkvYt3X/uCnpauTrnECLEUFijJqOOhkVcXV5VVzWWMnJNlY/Kn/tjjY6ilmzswrdpOcy3FiIGP9rOZuWgXftMUmH9RZR0b7SmIzAxbVe0WohLVmN6Ywc/bnAkUD97taC1J/RugV2sOKWhsCmm3S1od/6ZxEmfgI9RFK0ncWCcEAAC3fyrBN7lEaKZNIv4aZ7KHdOMmLwGXl5TGHUvv1R3eWQZ9ZsWdGr0vdBB27pZwlitU0dfROi76A/DWOw/8nLdfavDVtubxuvm2Ow749/111z4VuxqpN47FXqAni5zkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuupHnNfEuwBz+pNObSN2yC2efixkE69JEBZRv5CFCA=;
 b=HF8JhUWIN3aZN9zMByNBlys9qj2hlQT2K9VLJ7aq4hGq80lhcaGID9iuO3xspfkqXcWuUVMF1V2e1wpEmKeaBExsdnWPVyCp3OWklxfrbf/gVzAZmtVb61tlQfXKL8A9lNoBeQ7W/W0bndWyz1vRRgTg62Sqi5MENxX8kiUb8os=
Received: from SA0PR19MB4352.namprd19.prod.outlook.com (2603:10b6:806:8b::9)
 by PH7PR19MB5846.namprd19.prod.outlook.com (2603:10b6:510:1d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Fri, 26 May
 2023 21:23:53 +0000
Received: from SA0PR19MB4352.namprd19.prod.outlook.com
 ([fe80::ed08:afe9:48fe:6048]) by SA0PR19MB4352.namprd19.prod.outlook.com
 ([fe80::ed08:afe9:48fe:6048%6]) with mapi id 15.20.6455.012; Fri, 26 May 2023
 21:23:53 +0000
From:   Fred Treven <Fred.Treven@cirrus.com>
To:     Jeff LaBundy <jeff@labundy.com>
CC:     Ben Bright <Ben.Bright@cirrus.com>,
        James Ogletree <James.Ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>
Subject: Re: [PATCH RFC 5/5] mfd: cs40l26: Add CODEC driver component
Thread-Topic: [PATCH RFC 5/5] mfd: cs40l26: Add CODEC driver component
Thread-Index: AQHZj2WrmAzdJiNvPUas03v77O0RBa9s9eKAgAAcAwA=
Date:   Fri, 26 May 2023 21:23:53 +0000
Message-ID: <F6FA6CFA-BFC5-47DA-83D1-6330E66195F5@cirrus.com>
References: <1685059471-9598-1-git-send-email-fred.treven@cirrus.com>
 <1685059471-9598-5-git-send-email-fred.treven@cirrus.com>
 <ZHEL30a/YEia7kjr@nixie71>
In-Reply-To: <ZHEL30a/YEia7kjr@nixie71>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR19MB4352:EE_|PH7PR19MB5846:EE_
x-ms-office365-filtering-correlation-id: ec6f72b8-1775-4ca0-ae94-08db5e2f8186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kjosACKo7N7LKiGqTiVYLkLAAtTmxyp1lDhyMCcWpFh8tR5FeFlwnL3VaN1E5FQonU2jfObzQpZ5piqcYP7mNr+K5hVA2gc1TMuEZv3kh4eUt1zSLiOqcbsz9iwanugtxOxT0HHdbevv75jj37jzrqakjuQ+g4JgjBnYeatbjkP07F8y32jgkm0TuVk6UMojm1eXs45E9zi1S5jtcMpYdPa7Z3G4x1l+DaJPWmi/0SrqIe+JXhf7W5lGd6/qM03z1YuCzAkUBQW3BMUbWWgaN5LU+jwsHCaOxrk/upaSIZYbMJesHLHvL0c4CJG2D5O6UF1UOHaF6kJUakeDmxdWbEEs73onuvPJBn2c305NQmWAC+EBbF0cek2gZpQi1vner6PB/o/5MkRgNro2hoZ2F2608ybI/mQVhHRXrjCsIlhGcw+uI76z+m9WKFOSEQ4/4XzoqPN+dyctnedJWdjJhb1i0NXHCAJpLNFLhQPaFfABJeIG2P8/tjfbtf4wVdjztVuz4jbC5saVS/eiCcH/0597ts8HiuNF5IauMxhoHjbONT/pgQ66krHcBC4oCisZmW5bafN3ztv1wZoNk1cyptf5iIpmIZZMxw3uaExVm8SdhTfmXIUIQ9O0M6Vf0FcAfaE79tFg0HU//qkdH2sZzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR19MB4352.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39850400004)(136003)(346002)(396003)(451199021)(478600001)(54906003)(33656002)(83380400001)(38100700002)(2906002)(38070700005)(2616005)(122000001)(86362001)(6486002)(71200400001)(36756003)(186003)(6506007)(6512007)(53546011)(6916009)(5660300002)(4326008)(66446008)(66476007)(66556008)(64756008)(41300700001)(8936002)(66946007)(316002)(8676002)(76116006)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3RsVUE1bElXeWNnZEJWMWZvUTZCdTY5OEt6TG1UcmlEVUo4TlJIWGdOOWUx?=
 =?utf-8?B?ODZqV0lOS3N1bFpJdTJCdk82akpiL0ZxK2JxZHJkdVpiK2xVdUE2TFRJZm0x?=
 =?utf-8?B?NDV6R0lTRUJNWWd2VlVCRm9zcHkrT0lMeVFyS0Q0MVIxODZUNzJ2cFhZcTRX?=
 =?utf-8?B?S0x1NllldXViekcyQ1F0cVE2OVpIQVFzN0lxb09LME1lbU0vL2JSRUhDQnlm?=
 =?utf-8?B?S0dFZ1hmd0pGdGJqMUFDeHYyYUZFVzhGNFRxbm5ReE85cVFubStjbTdyOEdB?=
 =?utf-8?B?Q3hsZ0FhUHJ6TjFkUk8zNklZMk5OM1FGak51R1RmKzE1MWI4dzZGcFltZGVv?=
 =?utf-8?B?QytYbEpZUWZtTDdFVGE4Q2ZQL2tZUm1QUGcyQnVJcy9xY05KSTlnaWUxK21C?=
 =?utf-8?B?SkxSZUx0dFBrT0JtUFBXbDRmZExVOGVRWHRXUHVrb1FZdmlFZ3IvRXFQQTRs?=
 =?utf-8?B?Kzl4UnJnRVZCTHFRZXRYM283MG9yQWhDckZCSGNKWUx2eXdubzN1S0htM0Jq?=
 =?utf-8?B?TEtvV0JOZHBhTC9KSDhvaUdRZCtLaE9OTVNkM2h0UjVoYXlaQ0FxbUZYQ2gr?=
 =?utf-8?B?M0xSTCtWdHUvYmJxRE9icEtuVG1DcXNNOXY2SU8vU3N2Z1BteVVUaHdPUEx4?=
 =?utf-8?B?ZC95Sm01Y0dYc01VcTFLd1B6M3RSeVF6aXRxQnF2Skp1eU5BZTAvQWtEdE5I?=
 =?utf-8?B?TW1WRHhFbXN0RUlQZGMybXB4YURJV1NUZVdpais2YVp2TEUwUnFiaitLcnpk?=
 =?utf-8?B?WlEwU2Mrck85dDltQ21yaVJ0K1VGZFlESGhhR1BWTEh6dlI5YnN5VVNqck5Q?=
 =?utf-8?B?L0twM3Z2bFB5QVk5VTJnamhnL2RVcGV3UnBPcy80QlEyd21zbE1oZDdGOGJO?=
 =?utf-8?B?ZXNoVTFtYmFkL0dlZkdYOEZCN21vZlBDK1BPWUZlTmVxcXREaXpyK1laVU0z?=
 =?utf-8?B?R0d2U0ZKNUNSU3VabjhOWG14UlBxZEJ3YnlFVDRlNnJrQ2o1aGxCRVVySVE2?=
 =?utf-8?B?WEd4TEFudjVlMVh3elQ3ZmdjcEE3UDR3eG44L0VHU0ovcUZCTHFkWjRVMVlB?=
 =?utf-8?B?YjV6a1hBZTQzM056RnkyaktYMG81TGNvNHd4SnhHUVBSK2hLUS9nL1lkUFNZ?=
 =?utf-8?B?bjhNVTBXSWtSaWtZWTlDZm5NNjZuYzNocUh1dWxFM2pXY1Y0UHhRS3RHdXZI?=
 =?utf-8?B?T1I1VFVGV3EwaEZtdzRKTFkweE9PUjZycVU2MlRRSU9yN3NSV0pkbGRNM3dI?=
 =?utf-8?B?RnVvN0pLdGNydGRFZGhHaUJTRElVd2JQaFRoTk9xVHBFcjVTUnhkNTR3U0Z5?=
 =?utf-8?B?ODdQeXk2NExiZW1sWWorOG42QmM2QzE3YmozWGxJb2VxYmJzMmtpN0EzZ2tD?=
 =?utf-8?B?ZWczcTZ0bWh4ODFyOFprUTFMU0gxa205bDFzSGQxVW15YW9TNFIwMVlYSjlV?=
 =?utf-8?B?OXpPd3M4eUdid1QyYWI0UW1teC9MZmJlNVNhb1JwbDU3TXpiL0IrcWkxUlhK?=
 =?utf-8?B?dEN5T2tvT0oxaSsybkJDb2tibDZXN3FUbDRhUVNQRkF1ZWpUK2tWVVBqMzR4?=
 =?utf-8?B?T2dxLy92UnVLOXF5S0dGSmpuM2kyanl6STdxZ0doV2VJclk3bFhjZUdDUWtH?=
 =?utf-8?B?R3VBblZKRzlQS2liVkdxS3d6MWNDV0xUSGlTVVozOXphdkEzR0szZ2tVZHky?=
 =?utf-8?B?RVpvL0N3TnVXVkdTdWp4NmZ1RkhGWTlKNDI0UUhVdy8rc0lMRVllRWZXa2tw?=
 =?utf-8?B?QTFzT003RzRSbmpiRFNRUXJER3poUnJYb1IybVZoTW5ISGdZdzFEdEJaTkVI?=
 =?utf-8?B?RzdUWTI5UEZBamJUWEZYMGNhME9jNzBpREVWbEJ0L01nZHpkUlNFVXR2Q3JJ?=
 =?utf-8?B?ZStQZ0RLdzZGSytPOE5lTUt4YlYycC9LUWlVNlpsTFYvci9RbEdvSFhkeFlH?=
 =?utf-8?B?dEcxZ2liNVh5b2xlRnZFWVdmOG9PMFFTdU1XdkV0WnZ1T2JpbHZ1UzZjbU05?=
 =?utf-8?B?TXdtb093ZU51NXIydjhVdmw4MVp2OTg2Ly92Q3NNQ1JaMmcrbFNncHhteHRY?=
 =?utf-8?B?cU12VU1UekR0VEdZZkk5TStEa0VPYlk2T2ljOVcvUnR0WE1uOVIzTkx0SW5l?=
 =?utf-8?B?TmI0VnE2bE01THlYV0h4dC9NV1F0aGI5MjYxckhiTHhyK3AwT2VxYk0xSEtO?=
 =?utf-8?B?bTVtTWw2dlpkbTBTUTN4RGJZSWdvd0J4d0pmRVFCTFgyd0g4Y1dtK0ZybUlQ?=
 =?utf-8?B?ZFdVQjRXWmtmVEtaMTBVbU9FRkxRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF3A518E17D4894BB48C711559C97E6A@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR19MB4352.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6f72b8-1775-4ca0-ae94-08db5e2f8186
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 21:23:53.2484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIccqSgc4eUQ5cOXQMxt2nORwIeSCfSq6lnwm05rRhq3N1pexSYiN6tjStpAXOB7EayBtP+gdcUnGjscad62tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5846
X-Proofpoint-ORIG-GUID: 0c1siodvjLH1B2T1CVJXPR4y2vRkLTPZ
X-Proofpoint-GUID: 0c1siodvjLH1B2T1CVJXPR4y2vRkLTPZ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBKZWZmLA0KDQo+IE9uIE1heSAyNiwgMjAyMywgYXQgMjo0MyBQTSwgSmVmZiBMYUJ1bmR5
IDxqZWZmQGxhYnVuZHkuY29tPiB3cm90ZToNCj4gDQo+IEhpIEZyZWQsDQo+IA0KPiBPbiBUaHUs
IE1heSAyNSwgMjAyMyBhdCAwNzowNDozMVBNIC0wNTAwLCBGcmVkIFRyZXZlbiB3cm90ZToNCj4+
IFVzZSBNRkQgaW50ZXJmYWNlIHRvIGxvYWQgdGhlIENPREVDIGRyaXZlciBhbG9uZw0KPj4gd2l0
aCB0aGUgSW5wdXQgRkYgZHJpdmVyLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBGcmVkIFRyZXZl
biA8ZnJlZC50cmV2ZW5AY2lycnVzLmNvbT4NCj4+IC0tLQ0KPiANCj4gRGlkIHlvdSBtZWFuIHRv
IGluY2x1ZGUgYSB0aGluIGNvZGVjIGRyaXZlciBhcyBwYXJ0IG9mIHRoaXMgc2VyaWVzIHRvDQo+
IHN1cHBvcnQgdGhlIGF1ZGlvLXRvLWhhcHRpY3MgdXNlLWNhc2U/IEkgZG9uJ3Qgc2VlIG9uZS4N
Cg0KVGhhdCBpcyB0aGUgZW5kLWdvYWwsIGJ1dCBJIHdhbnRlZCB0byBzdWJtaXQgYSByZXF1ZXN0
IGZvciBjb21tZW50IHdpdGgganVzdCB0aGlzIHBhdGNoIHRvIHNlZSBpZiBpdCB3YXMgYXQgYWxs
IGFjY2VwdGFibGUgdG8gYWRkIGFub3RoZXIgZGV2aWNlIHRoaXMgd2F5LiBJIHNlZSBub3cgdGhh
dCBpdCBpcyBub3QuDQoNCj4gDQo+IEFzIExlZSBjb3JyZWN0bHkgcG9pbnRzIG91dCwgdGhpcyBp
c24ndCBhbiBNRkQgZGVzcGl0ZSB0aGUgdGl0bGUgb2YgdGhlDQo+IGNvbW1pdCBtZXNzYWdlLCBh
bmQgaXMgc29ydCBvZiBhbiBhYnVzZSBvZiB0aGUgQVBJLg0KDQpVbmRlcnN0b29kLiBEbyB5b3Ug
dGhpbmsgaXTigJlzIGJlc3QgdG8gbWlncmF0ZSB0aGUgYXBwcm9wcmlhdGUgY29kZSB0byB0aGUg
TUZEIHN1YnN5c3RlbSBiZWZvcmUgc3VibWl0dGluZyB0aGlzIGluaXRpYWwgcGF0Y2hzZXQgKHdo
aWNoIHdpbGwgaW5jbHVkZSB0aGUgY29kZWMgZHJpdmVyKSBvciB3b3VsZCBpdCBiZSBhY2NlcHRh
YmxlIHRvIG1ha2UgdGhhdCBjaGFuZ2UgYWZ0ZXIgdGhpcyBoYXMgZ29uZSBpbj8gTXkgaG9wZSB3
YXMgdG8gYXZvaWQgaGF2aW5nIGNvZGUgYmVpbmcgcmV2aWV3ZWQgbW9yZSB0aGFuIG9uY2UgaWYg
YSBzaWduaWZpY2FudCBwb3J0aW9uIGlzIG1vdmVkIHRvIE1GRC4NCg0KPiBXaGF0IHlvdSBzZWVt
IHRvIGFjdHVhbGx5IHdhbnQgaXMgYSB0cnVlIE1GRCBkcml2ZXIgcmVzcG9uc2libGUgZm9yDQo+
IGluaXRpYWxpemluZyBjb21tb24gcmVzb3VyY2VzIHN1Y2ggYXMgcmVnbWFwLCBhbiBJUlEgY2hp
cCwgZXRjLiBUaGF0DQo+IGRyaXZlciB0aGVuIGFkZHMgaW5wdXQgYW5kIGNvZGVjIGRyaXZlcnMg
YXMgY2hpbGRyZW4uDQo+IA0KPiBBdCB0aGUgbW9tZW50LCB5b3UncmUgbW9yZSBvciBsZXNzIHRy
ZWF0aW5nIHRoZSBpbnB1dCBkcml2ZXIgYXMgdGhlDQo+IE1GRCB3aXRoIG9uZSBjaGlsZCwgYnV0
IHRoYXQgaXMgbm90IHRoZSBjb3JyZWN0IHBhdHRlcm4uDQoNClllYWggdGhhdCBtYWtlcyBzZW5z
ZS4gUGxlYXNlIGFkdmlzZSBvbiB3aGF0IHRoZSBiZXN0IHdheSB0byBjb250aW51ZSB3b3VsZCBi
ZTogYS4gRHJvcCB0aGlzIHBhdGNoIGFuZCBtaWdyYXRlIHRvIE1GRCBhZnRlciB0aGUgSW5wdXQg
ZHJpdmVyIGhhcyBiZWVuIGFjY2VwdGVkIG9yIGIuIE1vdmUgbmVjZXNzYXJ5IGNvZGUgdG8gTUZE
IGFuZCBhZGQgYm90aCBJbnB1dCBhbmQgY29kZWMgZHJpdmVycyBmcm9tIHRoZXJlIGFsb25nIHdp
dGggdGhlIGNvZGVjIGRyaXZlci4NCg0KVGhhbmsgeW91LA0KRnJlZA0KDQoNCg==
