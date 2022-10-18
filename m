Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6977D6032F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJRTDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiJRTDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:03:05 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D51341507;
        Tue, 18 Oct 2022 12:03:04 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29II0Xcw015585;
        Tue, 18 Oct 2022 12:02:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=x+SrVn/Ld1fKceiH6ppsbp8HoygvpxkPWxc8+v11FIQ=;
 b=CgBYd4RkKqvXMUXEkQuuJ0XU7ZNHxvVkHJr5LcyUm8elv9oHItYU66ZwTHJ+idmePpwo
 s/UgZUJoyvOBv8oUBQEp+Dkf3/J47reNwFezXIQs326ruwFrD3hn41Lmn6Ki3f2VQIK1
 TDEGRXcXwOGAUa377KuxbUlFByByxy9vn/hGv1gNK6/DeU2IPN4BNhI+ksC3UCsJCD+5
 a/wYpHPvJerbqVzy/jaGg1ZAi3RazzjFAZ8Ab0/ZglRkl4G5yVKfWItviqP0GHKTAw1m
 jIIoV1E8M7gxABhiEhkDuNJO5evhEMG/mcrss/VCmhvdrewbWBZugRBH3nPbj24ZZIXo WQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3k7ughjujp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 12:02:51 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EBC6DC0109;
        Tue, 18 Oct 2022 19:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1666119770; bh=x+SrVn/Ld1fKceiH6ppsbp8HoygvpxkPWxc8+v11FIQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=hCG1B3dnn27Qa8RZl5yRtu3eiOjox1U0hozwfwy3Pzckey2jDRhuG7qxoY+ItU9pM
         /ELy4I+IRoGTtRJGIHSF2YE102JOHynDD12BW/L995oKz0EDXapQl0CUg+XSj7kWf8
         lga6V0dTa3TDntq02+69pzfIPmgJmgdpZCRj9OvJ/yk85/xATUdWpJm1GOllOy9RMr
         BFxxy2mvCsC9BQORXfIfOMm/l8Phyk8h70uJlaLLUfYNlqTaKJPMG0FTnupr/7H9jo
         OP3bAvw2yq1amVAAOG4mfuarwZ+blCWdtGGfV5vNGxEVvdrAxUm3r9EpbzZqpObOQl
         BVNln2ZgTeMuA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0E6D8A007F;
        Tue, 18 Oct 2022 19:02:49 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id BEDC6801FE;
        Tue, 18 Oct 2022 19:02:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="mV7GLuwp";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqqmBWAkmfByq6Kgv0bfLNmFM9RCxkLSKKlz6Db4tBQzS0C0zxcHUP2sr/m3dc0D7x9izmovdBkhbxuP6Qi6ZPTNNahvbieBy3AYxeCk5GdaW2aQYyqJgBid8DcE55qCgNMOQY8Of3BRsuoWm3qaHwxFdL5uVLS+c6le50seJrzpcBYiE6TKQedVkHLYdK6yHlbm8TT44oxH927os8Vb0O0mpXlXVJVhiQxL2/IN0sO/7f39NB7y4GZa/euUfQIaLjiMtbK+b/HBGPBeg6d6lSDCXcVJuskGvACn1ZPypvFYAKME4wiHG/Ay0zh5vUjnidk+RT7b+KbhyLT2HCdsDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+SrVn/Ld1fKceiH6ppsbp8HoygvpxkPWxc8+v11FIQ=;
 b=I3JU8aIVIppKvsuBYYV1yS3Np+t+F45+D29gtkUTqrw/k9ENlVUSMZR2WqAMfW6W2af2039C4BDDsGYRnmLAljOJYA6P8aJ4TRI/c9P0HXsPimwCewtLIBM2SGpxxI+fwMAYtkGnbWHpdHNp55cqGKATVl6g9b72MzALwo13vSJEeSSOL6WVtpzAw2Kxl5tjmI80W0zbqn7tNrfMTU4llOF/vTFGITnHPpTC9f2ZLaFH9rqwrWkyVS4DiELHZF/PBhGd2sxtL7/eS8SVzt8XjLEl8c5M+bsGq8qezzTouhnL5fpkavgc0qxWNhBgBgiAwin7nnInL2EIUseiERC9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+SrVn/Ld1fKceiH6ppsbp8HoygvpxkPWxc8+v11FIQ=;
 b=mV7GLuwpBRHRXkOPCDWO9pWvCSX6Y5OH7yPdG/Q+9uy/PwA3q64EnDvlNeggDBF0DxTOeuNOuLhCgc0WTG59azfAfWJPDI3XFZeQRzw2pyDC6jWs4bSnsopxC5709bGXIg+jHPcfz32OFGDPzt0b3d3tjyp5rI/njD0v1m5TkPg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 19:02:45 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::525b:92b6:eafc:8629]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::525b:92b6:eafc:8629%7]) with mapi id 15.20.5676.031; Tue, 18 Oct 2022
 19:02:44 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH v1 1/1] usb: dwc3: Don't switch OTG -> peripheral if
 extcon is present
Thread-Topic: [PATCH v1 1/1] usb: dwc3: Don't switch OTG -> peripheral if
 extcon is present
Thread-Index: AQHY4oETaPS/pzngb0C3HQhWfa4lOq4Ug2EA
Date:   Tue, 18 Oct 2022 19:02:44 +0000
Message-ID: <20221018190240.fijal6oncoxvijxh@synopsys.com>
References: <20221017233510.53336-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221017233510.53336-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DS0PR12MB6582:EE_
x-ms-office365-filtering-correlation-id: 30ee843b-d631-43be-dd90-08dab13b570f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 06fxWHNX+VO3Bxo+QS49gb/gZnDJh4f5Dnf5TZG8CNdmI40IDvBEy3ORQckFm0/1zwytvK6xFaKftzclDNfAdXhKmfCUHtp5ufKo4YNZ6jrjvikmnX/m44DlPgwOV4m1jYTby5jP+9BQFO7eQYp5UsqXKLy7Z2UnhKj9m+7S4aEEiKqpu7M3FqmNGCY0AJRbuO0JGOjgeyx0VwJCM6Piz1pcH5vmVUt3yYFDBmcaVyQ/3B24UDS2rKMhFgcaZEWMW3XxW9yLMszvy6aUiwb3O+hE9CAz+sxhWGRO2V7v2+/UuZfwK1Vs1rvOayo4LdtpzTY31bdRTwdJgbj4EwyFSalyXO4+cHkmb4M338y1tlDVK1ETKDrsiwhoZ/jiqn/dPI0oDSkuiFSubUPC9zWVO4zeTEjQq0PQBBmxu2BoDd8HMwO4vqynOkEhAP0ijoaGjaw/UZkjHa2DQGRijSEAjwz8pEgNBG6rOo7VVCStnQjs/w5xICt1U9lEfJOhDllvS00BHUHrqb/O8qC4Pb7h5noco4OP7ZBoGXQdAhpZ+TAta7EN74OFRVo31gAkPi+06ju7BckL1ee3pOdqcjqJ9ML8yOXHExqGsARKogTyMaXaDX/Mi1QQVe+goWIlnPDsuK5efxrZh8DkEPpEGC4G2rbFLNRSO0Z9qY19yjXGlxu8MIL+SueWo+cfZ7m5YFafAvsc/9ezb0dgcXL2zCiH1aaMh2nFUSZMd4LXQbDqqDZQLXDyJp2cpOi/TrzQNloq9qOGTycBEx8GxgN/k1YUkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199015)(122000001)(6512007)(6506007)(2616005)(26005)(83380400001)(1076003)(186003)(54906003)(2906002)(5660300002)(316002)(6486002)(76116006)(71200400001)(66446008)(41300700001)(8676002)(8936002)(4326008)(6916009)(66946007)(66476007)(66556008)(478600001)(64756008)(86362001)(36756003)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHBocFlVSWtlRnpYU2txcEVrR0wxeDBWQkJQNkFKU1U3bTV6NEhxTWo3MGp2?=
 =?utf-8?B?dWxQUWJRcDVHRzRPbUNqWDlHbXZsenI1aWdxTnQyYVRQZFJEaFYwMFZVTDBW?=
 =?utf-8?B?ckxZTjZOckE4d0kxSHVJVW9ZVHpBeSswcU1RK1JQdVFZaXhmTFNqdWJNUStq?=
 =?utf-8?B?VmpMNFBGc0NySGVpNUxQV1NSY1FIdHc5MFVQMXovelVFS2tJMWNodTBueTkw?=
 =?utf-8?B?bWNYVCtLbjRDeUNnRmo1QjFRS0o4MkhmejRQVVlSbU9hOENKRWI3R01LVVNo?=
 =?utf-8?B?aDdZU1NNeExqNmpVLzBFS2F6ZjZuaTVST0lKTWVyTWZ4TEhpdFoybWxkL0lC?=
 =?utf-8?B?WDQ0WTI0RWdzdzZqaC9pbEVxYklhZEVUNmtWSWNES05tUkxKTGlJcVZnL29z?=
 =?utf-8?B?OEhLR1NTQ0VCNmFVVnpmMGtRRXZnL00wM1E3TkF6NFpxbzJtSENDY2Z5VHgv?=
 =?utf-8?B?NzA1RnVzRm9pUUhsMDRvaTNHZHYwbE02MmxjakE1N3V1ZWVoaXFVWVVsWTNY?=
 =?utf-8?B?THQ0ZjlNU0gzaGkxWEp2UW9hTDRGZ0taaERzMmhsdHVITTRpcFFGdW1hMHB3?=
 =?utf-8?B?a1V5NmFyelhsVk9GT29JTjN0VUxOQlFRbHpXek5zS2VmejZKK3NUS0NpMHJ1?=
 =?utf-8?B?NWs0NG40M3lpckpnL243T1g0ZE9pVGwwZ2V5L2xydlJhK2ZOOWlpV21iMDgv?=
 =?utf-8?B?MHlFenYzZVdCSDRUN2RwY3dTc211TlE3azV6UjFwdElXY2VnT00rUjBCRGRB?=
 =?utf-8?B?RTJEb0EzSi9SKzBsVGdHNmdxOHRwd1h2QlA2Y2Y2UDVVQlZIeldMMm0yTUY2?=
 =?utf-8?B?Yk9KY0xtMHNMM3BtZUhvTHE1VHZ1by9Sd2xTOEpZWU13eSs2enNWQkNkZXhQ?=
 =?utf-8?B?UjFFbUFuSzBYQXZqR0pLWmFoZUtmLy9SaXU4ZEM0Mjh4VTRMTmhDcnlhU1hH?=
 =?utf-8?B?d29oSzI3MnpsbWJXQUNmbTg3VGIrQi9HekhKb0dJRnhpSG54aUxjWVZHaGhE?=
 =?utf-8?B?Mm5DVzNTRkE4WXpjUHBkbVVwSncyNDEvTWd2TWNta0pmVzFmRnF2MVQvQXlj?=
 =?utf-8?B?YkRXblFORjlUc0ZzZnJQNmlhbkdoSUlvYWIwbUR5UFdnNEllVmh3a3FjVEdl?=
 =?utf-8?B?Vnl5bk4vWDY4dmgvM0k3ek4wc0liT2VidndGS2JaWnBIZEF4UFc5NXh2R3Ri?=
 =?utf-8?B?bXdTUFh3RlcrTDJCbFcwSlNIUGdmc1hBZXRCRkQrR1dMbXU3VUVNNzdXODZM?=
 =?utf-8?B?MDFWZVBZMTFUWWI5S2tLZS9TaVl0N3ljakRnRVVkQUxyK3NYWERVOHZ1cDBj?=
 =?utf-8?B?M2Ntci80NDlPTWhVRHBEeDF4Y3NkNnVUV0E3SmQ0anNOYXZoSmFSSmI2YmpY?=
 =?utf-8?B?Y0EzTmFqNStCTmMzeGI5YjhNWnJ3WlQ5VllwbFI0a2MyeHlGN21EZmZJSWdP?=
 =?utf-8?B?TXZlWDh6TXRwMFBqNU1DMGl3MHcvZ3lrdXU2Q3hhQU13eGVZWWI0YTA0MHQ3?=
 =?utf-8?B?MHdlYWhTTE5SOHgyT3g1MFVQNWNlU1lHQmVBdnJqdkJvc1Y1NXFRaE1hL0Zt?=
 =?utf-8?B?OHJ6M25yNFdqd2JXT0VzVG1uYklkaDZPZzdKeWthd09BekpGckdZMWJzVGxh?=
 =?utf-8?B?WXVJT1k5WG9vUnV2bnJseTd6dG5kdlhuZ0drRk9Idkpyc2Q1anVnMjVRT3lV?=
 =?utf-8?B?dG85MnBqY0hNVUxvLzdpRUtvVGpZVzB1endySkFvUjFUVFAvNXN5ay9vS3gr?=
 =?utf-8?B?OHR1ZXZtWkhsbEF6RitRZmtaYWs0YjRqZHRNc0pac01leU5KVzlaOVA0Uk1V?=
 =?utf-8?B?bHo5S2NOdGM0T3k4S1pRV3p4VElMWWg3S2RVbTFvL2JlOUpQYy96Y21yRFBS?=
 =?utf-8?B?b2pBcFpTUVVSd3FyVWxXVCtrNklWUFNoa1dQc3B1OWxuQ3ZrUnV4YXVyZytZ?=
 =?utf-8?B?bExYdUp1aW42RjRXWXBGc2pOSDJUcThLWWZBS2Qyd1dySE0rWU1WVHpxVVBQ?=
 =?utf-8?B?R3BhaUhqemtnT0Y0dDhscFNhYTVzWkxJT1A4Vm9Yc0tpQ0VJNDIzcGR1VG1N?=
 =?utf-8?B?dzA5bEo4VDArd1hTTDNodVNKYUQyNEp2Uzh2Y3BOYWtyWk96amlWbUE3NkJ0?=
 =?utf-8?Q?h0mixgJF+AetE0b1g4x17C1D+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E532F4FBA91E14CAD8B71C97AD9BCEA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ee843b-d631-43be-dd90-08dab13b570f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 19:02:44.7878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UgTLhZBjtyPDgYd3HdHbuwelg5KTkAKlFwR4gkykHi2qUqjpH4/25fX5qclnu5zJ0+jxxcOw9ES4ERFvblzu0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582
X-Proofpoint-GUID: hSgz9aiS3owu3p5skpsbYZx3GQgSrN8F
X-Proofpoint-ORIG-GUID: hSgz9aiS3owu3p5skpsbYZx3GQgSrN8F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBPY3QgMTgsIDIwMjIsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gRnJvbTogQW5k
cmV5IFNtaXJub3YgPGFuZHJldy5zbWlybm92QGdtYWlsLmNvbT4NCj4gDQo+IElmIHRoZSBleHRj
b24gZGV2aWNlIGV4aXN0cywgZ2V0IHRoZSBtb2RlIGZyb20gdGhlIGV4dGNvbiBkZXZpY2UuIElm
DQo+IHRoZSBjb250cm9sbGVyIGlzIERSRCBhbmQgdGhlIGRyaXZlciBpcyB1bmFibGUgdG8gZGV0
ZXJtaW5lIHRoZSBtb2RlLA0KPiBvbmx5IHRoZW4gZGVmYXVsdCB0aGUgZHJfbW9kZSB0byBVU0Jf
RFJfTU9ERV9QRVJJUEhFUkFMLg0KPiANCj4gUmVwb3J0ZWQtYnk6IFN0ZWV2IEtsaW1hc3pld3Nr
aSA8c3RlZXZAa2FsaS5vcmc+DQo+IEZpeGVzOiA3YTg0ZTczNTNlMjMgKCJSZXZlcnQgInVzYjog
ZHdjMzogRG9uJ3Qgc3dpdGNoIE9URyAtPiBwZXJpcGhlcmFsIGlmIGV4dGNvbiBpcyBwcmVzZW50
IiIpDQo+IFJldmlld2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTbWlybm92IDxhbmRyZXcuc21pcm5vdkBnbWFp
bC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVu
a29AbGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwg
NDkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgZHJpdmVycy91
c2IvZHdjMy9kcmQuYyAgfCA1MCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspLCA1MSBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IGVhNTE2MjQ0NjFiNS4uYzBlN2M3NmRjNWM4IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYw0KPiBAQCAtMjMsNiArMjMsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5
Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4NCj4gICNpbmNsdWRlIDxsaW51
eC9vZi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L29mX2dyYXBoLmg+DQo+ICAjaW5jbHVkZSA8bGlu
dXgvYWNwaS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BpbmN0cmwvY29uc3VtZXIuaD4NCj4gICNp
bmNsdWRlIDxsaW51eC9yZXNldC5oPg0KPiBAQCAtODUsNyArODYsNyBAQCBzdGF0aWMgaW50IGR3
YzNfZ2V0X2RyX21vZGUoc3RydWN0IGR3YzMgKmR3YykNCj4gIAkJICogbW9kZS4gSWYgdGhlIGNv
bnRyb2xsZXIgc3VwcG9ydHMgRFJEIGJ1dCB0aGUgZHJfbW9kZSBpcyBub3QNCj4gIAkJICogc3Bl
Y2lmaWVkIG9yIHNldCB0byBPVEcsIHRoZW4gc2V0IHRoZSBtb2RlIHRvIHBlcmlwaGVyYWwuDQo+
ICAJCSAqLw0KPiAtCQlpZiAobW9kZSA9PSBVU0JfRFJfTU9ERV9PVEcgJiYNCj4gKwkJaWYgKG1v
ZGUgPT0gVVNCX0RSX01PREVfT1RHICYmICFkd2MtPmVkZXYgJiYNCj4gIAkJICAgICghSVNfRU5B
QkxFRChDT05GSUdfVVNCX1JPTEVfU1dJVENIKSB8fA0KPiAgCQkgICAgICFkZXZpY2VfcHJvcGVy
dHlfcmVhZF9ib29sKGR3Yy0+ZGV2LCAidXNiLXJvbGUtc3dpdGNoIikpICYmDQo+ICAJCSAgICAh
RFdDM19WRVJfSVNfUFJJT1IoRFdDMywgMzMwQSkpDQo+IEBAIC0xNjkwLDYgKzE2OTEsNDYgQEAg
c3RhdGljIHZvaWQgZHdjM19jaGVja19wYXJhbXMoc3RydWN0IGR3YzMgKmR3YykNCj4gIAl9DQo+
ICB9DQo+ICANCj4gK3N0YXRpYyBzdHJ1Y3QgZXh0Y29uX2RldiAqZHdjM19nZXRfZXh0Y29uKHN0
cnVjdCBkd2MzICpkd2MpDQo+ICt7DQo+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gZHdjLT5kZXY7
DQo+ICsJc3RydWN0IGRldmljZV9ub2RlICpucF9waHk7DQo+ICsJc3RydWN0IGV4dGNvbl9kZXYg
KmVkZXYgPSBOVUxMOw0KPiArCWNvbnN0IGNoYXIgKm5hbWU7DQo+ICsNCj4gKwlpZiAoZGV2aWNl
X3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsICJleHRjb24iKSkNCj4gKwkJcmV0dXJuIGV4dGNvbl9n
ZXRfZWRldl9ieV9waGFuZGxlKGRldiwgMCk7DQo+ICsNCj4gKwkvKg0KPiArCSAqIERldmljZSB0
cmVlIHBsYXRmb3JtcyBzaG91bGQgZ2V0IGV4dGNvbiB2aWEgcGhhbmRsZS4NCj4gKwkgKiBPbiBB
Q1BJIHBsYXRmb3Jtcywgd2UgZ2V0IHRoZSBuYW1lIGZyb20gYSBkZXZpY2UgcHJvcGVydHkuDQo+
ICsJICogVGhpcyBkZXZpY2UgcHJvcGVydHkgaXMgZm9yIGtlcm5lbCBpbnRlcm5hbCB1c2Ugb25s
eSBhbmQNCj4gKwkgKiBpcyBleHBlY3RlZCB0byBiZSBzZXQgYnkgdGhlIGdsdWUgY29kZS4NCj4g
KwkgKi8NCj4gKwlpZiAoZGV2aWNlX3Byb3BlcnR5X3JlYWRfc3RyaW5nKGRldiwgImxpbnV4LGV4
dGNvbi1uYW1lIiwgJm5hbWUpID09IDApDQo+ICsJCXJldHVybiBleHRjb25fZ2V0X2V4dGNvbl9k
ZXYobmFtZSk7DQo+ICsNCj4gKwkvKg0KPiArCSAqIFRyeSB0byBnZXQgYW4gZXh0Y29uIGRldmlj
ZSBmcm9tIHRoZSBVU0IgUEhZIGNvbnRyb2xsZXIncyAicG9ydCINCj4gKwkgKiBub2RlLiBDaGVj
ayBpZiBpdCBoYXMgdGhlICJwb3J0IiBub2RlIGZpcnN0LCB0byBhdm9pZCBwcmludGluZyB0aGUN
Cj4gKwkgKiBlcnJvciBtZXNzYWdlIGZyb20gdW5kZXJseWluZyBjb2RlLCBhcyBpdCdzIGEgdmFs
aWQgY2FzZTogZXh0Y29uDQo+ICsJICogZGV2aWNlIChhbmQgInBvcnQiIG5vZGUpIG1heSBiZSBt
aXNzaW5nIGluIGNhc2Ugb2YgInVzYi1yb2xlLXN3aXRjaCINCj4gKwkgKiBvciBPVEcgbW9kZS4N
Cj4gKwkgKi8NCj4gKwlucF9waHkgPSBvZl9wYXJzZV9waGFuZGxlKGRldi0+b2Zfbm9kZSwgInBo
eXMiLCAwKTsNCj4gKwlpZiAob2ZfZ3JhcGhfaXNfcHJlc2VudChucF9waHkpKSB7DQo+ICsJCXN0
cnVjdCBkZXZpY2Vfbm9kZSAqbnBfY29ubjsNCj4gKw0KPiArCQlucF9jb25uID0gb2ZfZ3JhcGhf
Z2V0X3JlbW90ZV9ub2RlKG5wX3BoeSwgLTEsIC0xKTsNCj4gKwkJaWYgKG5wX2Nvbm4pDQo+ICsJ
CQllZGV2ID0gZXh0Y29uX2ZpbmRfZWRldl9ieV9ub2RlKG5wX2Nvbm4pOw0KPiArCQlvZl9ub2Rl
X3B1dChucF9jb25uKTsNCj4gKwl9DQo+ICsJb2Zfbm9kZV9wdXQobnBfcGh5KTsNCj4gKw0KPiAr
CXJldHVybiBlZGV2Ow0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IGR3YzNfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlCQkqZGV2ID0g
JnBkZXYtPmRldjsNCj4gQEAgLTE4NDAsNiArMTg4MSwxMiBAQCBzdGF0aWMgaW50IGR3YzNfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJZ290byBlcnIyOw0KPiAgCX0N
Cj4gIA0KPiArCWR3Yy0+ZWRldiA9IGR3YzNfZ2V0X2V4dGNvbihkd2MpOw0KPiArCWlmIChJU19F
UlIoZHdjLT5lZGV2KSkgew0KPiArCQlyZXQgPSBkZXZfZXJyX3Byb2JlKGR3Yy0+ZGV2LCBQVFJf
RVJSKGR3Yy0+ZWRldiksICJmYWlsZWQgdG8gZ2V0IGV4dGNvblxuIik7DQo+ICsJCWdvdG8gZXJy
MzsNCj4gKwl9DQo+ICsNCj4gIAlyZXQgPSBkd2MzX2dldF9kcl9tb2RlKGR3Yyk7DQo+ICAJaWYg
KHJldCkNCj4gIAkJZ290byBlcnIzOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9k
cmQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHJkLmMNCj4gaW5kZXggOGNhZDllN2QzMzY4Li4wMzli
ZjI0MTc2OWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHJkLmMNCj4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9kcmQuYw0KPiBAQCAtOCw3ICs4LDYgQEANCj4gICAqLw0KPiAgDQo+
ICAjaW5jbHVkZSA8bGludXgvZXh0Y29uLmg+DQo+IC0jaW5jbHVkZSA8bGludXgvb2ZfZ3JhcGgu
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L3BsYXRmb3JtX2RldmljZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3Byb3BlcnR5Lmg+DQo+IEBA
IC00MzksNTEgKzQzOCw2IEBAIHN0YXRpYyBpbnQgZHdjM19kcmRfbm90aWZpZXIoc3RydWN0IG5v
dGlmaWVyX2Jsb2NrICpuYiwNCj4gIAlyZXR1cm4gTk9USUZZX0RPTkU7DQo+ICB9DQo+ICANCj4g
LXN0YXRpYyBzdHJ1Y3QgZXh0Y29uX2RldiAqZHdjM19nZXRfZXh0Y29uKHN0cnVjdCBkd2MzICpk
d2MpDQo+IC17DQo+IC0Jc3RydWN0IGRldmljZSAqZGV2ID0gZHdjLT5kZXY7DQo+IC0Jc3RydWN0
IGRldmljZV9ub2RlICpucF9waHk7DQo+IC0Jc3RydWN0IGV4dGNvbl9kZXYgKmVkZXYgPSBOVUxM
Ow0KPiAtCWNvbnN0IGNoYXIgKm5hbWU7DQo+IC0NCj4gLQlpZiAoZGV2aWNlX3Byb3BlcnR5X3Jl
YWRfYm9vbChkZXYsICJleHRjb24iKSkNCj4gLQkJcmV0dXJuIGV4dGNvbl9nZXRfZWRldl9ieV9w
aGFuZGxlKGRldiwgMCk7DQo+IC0NCj4gLQkvKg0KPiAtCSAqIERldmljZSB0cmVlIHBsYXRmb3Jt
cyBzaG91bGQgZ2V0IGV4dGNvbiB2aWEgcGhhbmRsZS4NCj4gLQkgKiBPbiBBQ1BJIHBsYXRmb3Jt
cywgd2UgZ2V0IHRoZSBuYW1lIGZyb20gYSBkZXZpY2UgcHJvcGVydHkuDQo+IC0JICogVGhpcyBk
ZXZpY2UgcHJvcGVydHkgaXMgZm9yIGtlcm5lbCBpbnRlcm5hbCB1c2Ugb25seSBhbmQNCj4gLQkg
KiBpcyBleHBlY3RlZCB0byBiZSBzZXQgYnkgdGhlIGdsdWUgY29kZS4NCj4gLQkgKi8NCj4gLQlp
ZiAoZGV2aWNlX3Byb3BlcnR5X3JlYWRfc3RyaW5nKGRldiwgImxpbnV4LGV4dGNvbi1uYW1lIiwg
Jm5hbWUpID09IDApIHsNCj4gLQkJZWRldiA9IGV4dGNvbl9nZXRfZXh0Y29uX2RldihuYW1lKTsN
Cj4gLQkJaWYgKCFlZGV2KQ0KPiAtCQkJcmV0dXJuIEVSUl9QVFIoLUVQUk9CRV9ERUZFUik7DQo+
IC0NCj4gLQkJcmV0dXJuIGVkZXY7DQo+IC0JfQ0KPiAtDQo+IC0JLyoNCj4gLQkgKiBUcnkgdG8g
Z2V0IGFuIGV4dGNvbiBkZXZpY2UgZnJvbSB0aGUgVVNCIFBIWSBjb250cm9sbGVyJ3MgInBvcnQi
DQo+IC0JICogbm9kZS4gQ2hlY2sgaWYgaXQgaGFzIHRoZSAicG9ydCIgbm9kZSBmaXJzdCwgdG8g
YXZvaWQgcHJpbnRpbmcgdGhlDQo+IC0JICogZXJyb3IgbWVzc2FnZSBmcm9tIHVuZGVybHlpbmcg
Y29kZSwgYXMgaXQncyBhIHZhbGlkIGNhc2U6IGV4dGNvbg0KPiAtCSAqIGRldmljZSAoYW5kICJw
b3J0IiBub2RlKSBtYXkgYmUgbWlzc2luZyBpbiBjYXNlIG9mICJ1c2Itcm9sZS1zd2l0Y2giDQo+
IC0JICogb3IgT1RHIG1vZGUuDQo+IC0JICovDQo+IC0JbnBfcGh5ID0gb2ZfcGFyc2VfcGhhbmRs
ZShkZXYtPm9mX25vZGUsICJwaHlzIiwgMCk7DQo+IC0JaWYgKG9mX2dyYXBoX2lzX3ByZXNlbnQo
bnBfcGh5KSkgew0KPiAtCQlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wX2Nvbm47DQo+IC0NCj4gLQkJ
bnBfY29ubiA9IG9mX2dyYXBoX2dldF9yZW1vdGVfbm9kZShucF9waHksIC0xLCAtMSk7DQo+IC0J
CWlmIChucF9jb25uKQ0KPiAtCQkJZWRldiA9IGV4dGNvbl9maW5kX2VkZXZfYnlfbm9kZShucF9j
b25uKTsNCj4gLQkJb2Zfbm9kZV9wdXQobnBfY29ubik7DQo+IC0JfQ0KPiAtCW9mX25vZGVfcHV0
KG5wX3BoeSk7DQo+IC0NCj4gLQlyZXR1cm4gZWRldjsNCj4gLX0NCj4gLQ0KPiAgI2lmIElTX0VO
QUJMRUQoQ09ORklHX1VTQl9ST0xFX1NXSVRDSCkNCj4gICNkZWZpbmUgUk9MRV9TV0lUQ0ggMQ0K
PiAgc3RhdGljIGludCBkd2MzX3VzYl9yb2xlX3N3aXRjaF9zZXQoc3RydWN0IHVzYl9yb2xlX3N3
aXRjaCAqc3csDQo+IEBAIC01ODgsMTAgKzU0Miw2IEBAIGludCBkd2MzX2RyZF9pbml0KHN0cnVj
dCBkd2MzICpkd2MpDQo+ICAJICAgIGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZHdjLT5kZXYs
ICJ1c2Itcm9sZS1zd2l0Y2giKSkNCj4gIAkJcmV0dXJuIGR3YzNfc2V0dXBfcm9sZV9zd2l0Y2go
ZHdjKTsNCj4gIA0KPiAtCWR3Yy0+ZWRldiA9IGR3YzNfZ2V0X2V4dGNvbihkd2MpOw0KPiAtCWlm
IChJU19FUlIoZHdjLT5lZGV2KSkNCj4gLQkJcmV0dXJuIFBUUl9FUlIoZHdjLT5lZGV2KTsNCj4g
LQ0KPiAgCWlmIChkd2MtPmVkZXYpIHsNCj4gIAkJZHdjLT5lZGV2X25iLm5vdGlmaWVyX2NhbGwg
PSBkd2MzX2RyZF9ub3RpZmllcjsNCj4gIAkJcmV0ID0gZXh0Y29uX3JlZ2lzdGVyX25vdGlmaWVy
KGR3Yy0+ZWRldiwgRVhUQ09OX1VTQl9IT1NULA0KPiAtLSANCj4gMi4zNS4xDQo+IA0KDQpBY2tl
ZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3Ms
DQpUaGluaA==
