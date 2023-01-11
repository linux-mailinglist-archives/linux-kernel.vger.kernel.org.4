Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0C966502E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjAKABa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbjAKABA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:01:00 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3E81A385;
        Tue, 10 Jan 2023 16:00:58 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ALbe9d009064;
        Tue, 10 Jan 2023 16:00:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=3pUAQgKKReDvs0GqXaT7PiWYmzkjow8/S1atOf/jkpo=;
 b=a53tFB9mq+GgNSJCLZED20EFiMpVzvqNiOCuo6e5XRgVkiO8m7YLBl4HWdKm3inn7Rgz
 cLvzrZWAWN1nk8F9IL2+rypjtSzouHL2QUdIuE+T23ZoxezTfrZDIJKJJFg0S2PFgZ9x
 zmE0t3lmPZqTAaZsnVGfilGTohENNKR2DdRFTPaLzcUQ6Ok8LkuydgW0hXLRH0TqctAn
 sKJOhA1C7+qOKi1vLzCVJDTm7ym884CT94ykbLmdo+zEMA5DJfxdGdZLlREgaU30IYvc
 6go/CFhfJq732oKEYihhZbGBgccCwKp/eeE/kdARjcqIk/V69VzflGKzIYMGfsULDk4m wg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3my88nhucw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 16:00:40 -0800
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A6571C00F3;
        Wed, 11 Jan 2023 00:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1673395239; bh=3pUAQgKKReDvs0GqXaT7PiWYmzkjow8/S1atOf/jkpo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WAO2b4iU2LhYD73HcmBjAl8qH4o8KiLboJqHy7zgLdtW1zshE3vak6WrG0Z/kIc+I
         eVmAtMkj3B95cyDD3xezeM7yRkjW4Hhxz2TZvwzwwAOzshenw6jqO0oE6WoEsolRHo
         MaWDCIBxwK9Wgza+SekHUm4Ev2yeTOMgG2Ch0RG+MU/ohXMWAGQlHNUD4jyy3JMz1t
         3GAFZBD30krnL7LMUiTMG/c22Hi2Y5e98ecZ2kekNG5bWGb5nCv3+pbkijcVO0UEqT
         u7DBsJW3pisnFjMThw+qGAmkMIHkNuy2a3IKykwxJ9KaVnzSDXXViWknnLg5xT2fzc
         /p0hghlc/6XhA==
Received: from o365relay-in.synopsys.com (us03-o365relay7.synopsys.com [10.4.161.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 85EDAA008A;
        Wed, 11 Jan 2023 00:00:37 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id F4219A004A;
        Wed, 11 Jan 2023 00:00:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="v23L6V2a";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6RyP+swrSL468U2r2zmmfPpOeizAFYkFQLJ8l52ULIqgbvvIzlLY6zWtv/9jAMq0CZM7J3EdBYefans9UVE3InLbL8HdFIRLrwK5LgtEjRFr1g2IqyVKrKIL5KI77rkSM+vm3QiuTQyGV9/uBkBvOl5d4lACkhRDoytW222jjOJws86Sf4VMl6yS/8nNbYBFK3VSWFoAWeH9eLeYFbK3IYYBOqHiTjsO95SMSf7pthU8Ex3oYanG7BdpJEviLe3u5pL6qp5u4U9QaZfBdO6J+iMybhgJbCRyO5YLwgqNJ8NqTC+NIO0OtvUwl+pTaOglxKEN6eYkp1Tzu1oVRxggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pUAQgKKReDvs0GqXaT7PiWYmzkjow8/S1atOf/jkpo=;
 b=jS53ecPI8Zdhae4iqv4fiGYzc22llAJQKtaNFgfSsNJo2JVWTq9vrZaeptGiv6GJqoPCWU6MSNmPnpIHe7ASxzoFgyBha+ILXrBdbAiyo3MtADl3EMH0PuCN3HZZFX1Vu3CMINxWY/+IsMwqxdMhNbDDFCwJ17QZ/QzCsjVCxQ1+EVeLWkmCpgoFK+IUpbEjdFZMiIUkP6r85MCrgD/ew1UiIgDMkOBagg9pY5j8APYEPm42TXHEZ1WPkaAMVwwF8k0FoOlUB4quXV715OwePmMmYMDDW/trFg2JLL3fy+BZTd56OHe7ADPS57NW48fYLuom5aAs4gRFpQSrsmLFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pUAQgKKReDvs0GqXaT7PiWYmzkjow8/S1atOf/jkpo=;
 b=v23L6V2aZL1Qzv3mmX5U13MxWvF8SDLpQgmtK5l5yhL2Ryd9Ljv2dU10UFq+Hwzx2xELvokpWwsUEQuPyKX7YRGcWOadzXBphlwyMHg8/LH35fK+ImjfG/DXw2UYDkbd+Dt2UHPJdsryXCI9xZi7ni4TB5W2vI7B/igYxp7V5Ho=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:20a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 00:00:32 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee%4]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 00:00:32 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        =?utf-8?B?7KCV7J6s7ZuI?= <jh0801.jung@samsung.com>,
        'Felipe Balbi' <balbi@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "'open list:USB XHCI DRIVER'" <linux-usb@vger.kernel.org>,
        'open list' <linux-kernel@vger.kernel.org>,
        'Seungchull Suh' <sc.suh@samsung.com>,
        'Daehwan Jung' <dh10.jung@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
Thread-Topic: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
Thread-Index: AQHZHmjkAYxM4HeOyE6Dd8zsa51+rq6PLu+AgAABtICAAGoRgIABIhKAgAW2rICAAH0sAIAAD+kAgAADfgCAAAI7gIAAShIAgAESQYA=
Date:   Wed, 11 Jan 2023 00:00:32 +0000
Message-ID: <20230111000021.r2bd5gnfwlbxzxd3@synopsys.com>
References: <af32e2f5-de45-38af-2b4f-47c1ac21ea9e@quicinc.com>
 <c4e01a0a-1c98-3103-2b91-2fe0ba8c3118@quicinc.com>
 <000201d920eb$c3715c50$4a5414f0$@samsung.com>
 <0bbd2355-2290-17c7-6860-d8b25930aed6@quicinc.com>
 <20230109182813.sle5h34wdgglnlph@synopsys.com>
 <e7217471-5b08-eee6-fba8-06e879118d77@quicinc.com>
 <20230110025310.nowjnrmo3oag76xd@synopsys.com>
 <4ced9c3e-c7b5-e0a0-88ec-1ac383d893a2@quicinc.com>
 <bfcfac21-3df7-7f47-576b-0717f2bab393@quicinc.com>
 <f35f0636-5b3f-9002-77f3-a3c2c53be973@quicinc.com>
In-Reply-To: <f35f0636-5b3f-9002-77f3-a3c2c53be973@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MW4PR12MB7032:EE_
x-ms-office365-filtering-correlation-id: 5e3098db-3472-47da-7a1b-08daf366dbdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q0V2n1/2SdrPgfTa0wsNbRScu7oDcUoLW75jPZJpW8OQu8hm1h9lBOiayG/1OClwuyc6BfhRwD1VpK/G5sscOmCINAaEbnG0NMUt0IQU5u9TngKczDPxNLdJKPXw8sHpszank2Sy7yPfzzvF/b+ddf9VLTGDYwpLV2Am9+P0sTkiIZ2ZU8duLSVo50QcMaidFtRWQCYApkd0yg64ILDaSf15CrxiarEFAjGlRtN6zvKEOBBpeqmNQbplfjhUg5LIvzKMLr0fPal04g47838CGfqu5/iVEsybxsk+0sSPXBQ6g4BbH6ua06WSaCYo4ZlypVUVd1RO8ivYSPj3rbfiqcc2DBAbzRpZHFk6353TTB/IdkDk3lyx0bvqICZRjqf5QIrDmPg6N6MRB0NAI3FOoI8/+Qyx9EcNZ6bDa+0yN2R+yTsLF2UGoHoFSv7znneDm8mNGrd2/sfwfIX7fGmi3fPUr3k8da/bEmILnsWoHat/7krgYr2tNAaUIUGtMXoa++FXT8AJTyz0bqvZA/o5x/kjUA2jg5Qs3O6HR02AosEQkEK6JLw+pm5iKXvXbNBQNlYPkMmZQO6/tRPwLirNzu26q1jUaw/2ezh41sNM88pRGWNEKIK0hlmoyuujTo7AS/2at3CEYyNGbXGxCyxOBJs+94K9v+T9kTJvs1kNke3r7LmnK9PRlK12dnMW86cH8rUacwKhZSdjr5NWJtbramuu2CGQ9MzwWojqfwFfbi4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(66946007)(1076003)(54906003)(2616005)(66446008)(41300700001)(6916009)(4326008)(316002)(8676002)(66556008)(36756003)(76116006)(66476007)(64756008)(86362001)(38070700005)(122000001)(83380400001)(38100700002)(5660300002)(8936002)(6486002)(2906002)(71200400001)(6506007)(6512007)(53546011)(478600001)(186003)(26005)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjYyeHg4YzZrcTBVcHdaNXZhKzcwWk1nS0Q0MDVkU3MyalVvcUUycTFoNytT?=
 =?utf-8?B?d2VUeklHVlREemlqcjlWYmRmZmVpZXRSV0JZKy95c05YL3dBTUhFWXJSdUFr?=
 =?utf-8?B?TDJsNDNEZkNsMm5uWjE2UmpMSko2dmV1aDA3Y21sTVdndWFVc3ZtQ0FMNXhM?=
 =?utf-8?B?YUsrWmZzZUtrZmFrRERPN1J1eTNnWUhoZzNWS2xkdEJrSTJ3MUx0VnNWUmxa?=
 =?utf-8?B?NmoraEs1cW9DSGRCTFVKMGZ4UDBJZE5qNTY5cml4dzM4VWk4RDRyMUFoeTgr?=
 =?utf-8?B?UWg3amJLelNrZENPS1RxMzJhZnVXcjdKWXdFRWdTQ2tVQXNDOC81U0pxS3dN?=
 =?utf-8?B?RkFyMHU3dElNU0tpL0dBanhYajVEMGRTbnc4SVY2RjdZVUNLNEh2ZTF3dVd3?=
 =?utf-8?B?TERHMUcyRHFlcGx3UjBFZjhRbjNQTXVsaTByYVdZdFY4elRtd2EybEJJdWVo?=
 =?utf-8?B?T1h5K3RXNWd2Yzd2bFVwSSt6WjRwUHM1M0tMOFJuRmdoNENhS282dUJSUkRS?=
 =?utf-8?B?MlU0OVpxZ01VSEpLTGJlZ0luajk5a0p2amxrNVdNczJPR0U3dU5JU0JxLzRr?=
 =?utf-8?B?OTZmTjZ3Wi9ldzQ2UmQ0ek5RV1QxM0JydE5iRklRY3YxMklLMUNxSUY2TUli?=
 =?utf-8?B?cWF1KytvdGNqaWV5b1poNVBYL1NJL1ZxQkFaLzBSRWVPd2RSazIxcC84T09D?=
 =?utf-8?B?TFJNR0tTTkNHTGVBc2IzaldIc3NuM21TY2pkQjZLYXBqR2QzWVZ0MC8ybTZU?=
 =?utf-8?B?ZGc3Zk5CbFZWUTZWcVFRWDA2bmpZNWxXaVRENWJpajJMakIxcGxsRTFwSWg1?=
 =?utf-8?B?cGxCUU9TMlR0T1NQV0NOZEI4UFJIMHdVYUhDSVhuTUxBSlpodktSTzVOL3RJ?=
 =?utf-8?B?eGV0Z3FNaWQwTDVucWthb3NoOUw2UDFLOTFpVm05RWZ3c3lKajFMbDFRZHBG?=
 =?utf-8?B?SXZndjFESXl2Qy8wL2d1eG9UNWRkdVRldWRJRGdjempTbFdoUjY5TmJZZVJy?=
 =?utf-8?B?TlVDblFneEpSNXg4ZTJOZWtMNDUvcVZ0UjRvQzdISGN5N0tVdUdPa3pUK3da?=
 =?utf-8?B?M2E5V1R3dWZod2ZsbVFmNTlYYkExZDl6T1cxZEdPN0o1T2hnblhLanVkSVBr?=
 =?utf-8?B?OEg0TmNDME52dVFjVEJzS3VGeGFvRjcwd2w5azFDTmE0eC9rdWxDQWNnOTJC?=
 =?utf-8?B?d2ZVOWl2bGRlTUNSOTFzUGgrWHZaMFlMWGdYMzJ2LzgxWGpuSU83QUNCUXRy?=
 =?utf-8?B?ZGk0QVdtOW1EdiswbGRsS09DMk9FYnFmTzljNE0ya09kVW9hOGlDQnA1Njd4?=
 =?utf-8?B?Ukc2MndDMkFCVlhoamxKMlAxcnpjYmdjNVVMTVE1RXZoWGJwaEVsZXRnd3lT?=
 =?utf-8?B?YlBLclg0VmZOOGN0bFZSY0RKL2JIUG9VTThpcGp5WUFSalQ1NXozdTNxQklY?=
 =?utf-8?B?cWV2bm0vRmE2NC8yMVRHeUFCSVFSbmFjdnc5cHByc3dwbHEzYjZhd292UFBn?=
 =?utf-8?B?bGptVE5HN2t0NXM4RjAvOGx2Z1lGUDhHWEJxTDJaVHk0WlZVUGdSZXVzNmdL?=
 =?utf-8?B?cUJhZ1pZUWxhK2R1VEt2ZEVuWllZRkxwclZiZjlTcVNiNldINjFaTnFVajBz?=
 =?utf-8?B?bHFwcFdxZVV0d2xvYTkzdkFnSGtnVFcySkczWC9URHhxSURnV1kyUS9ORGFJ?=
 =?utf-8?B?YzZuSWd6UUlLZXd6dzB0clU0ekdZcEpOelRKN2hrVjVabmtQWjJLOUtYUDU0?=
 =?utf-8?B?dExQUUtSblBtcFNncjl4N3RVWE51NmhrVXFEL283ejgzRk81R1FoMW56TGRB?=
 =?utf-8?B?eFRVMyswb0xiNzRvZWVLUWF2VVMxVkJrSFJlWHNXUDBmeWFURjlaR3h6Y0o4?=
 =?utf-8?B?OFEzVFExWnd2OHlKTFdjcXNHMElXTDB0UHJFVDVUeVVRQWRpSlhIYTV0S041?=
 =?utf-8?B?VURwMGpHb0lFS3o4Y29wRlJuV3RVTXFDVG56bUJrN3BrWFFvT1laYmtCNGpN?=
 =?utf-8?B?TEhJNUdZeFV1bXdkUkMxT05CL0JLUEJ0SUoxcE5XUUFrUFZ0Uk16c0JJU1Br?=
 =?utf-8?B?VGxJUUNTOWlGdmpBbFVPWEtQSHM0R0duOWdrUjhBS3VoMzR1a2pGNUl2a002?=
 =?utf-8?Q?jE1NcdRKI0t/O5IhMhuCcyDMr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E922E97D4A6CE24AAB58CC6DBE3C5A2E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QVcxOWhab2t6d0xYTUdTMjVwdVhmeTBiUURFSS9QbElDZTYzRVJ1WmZhL0Ux?=
 =?utf-8?B?NjRmWlVRMXhlNGQ1Y2VleWRlNnhuRFdzdzlOdzJWNjkxMUcrcHkvRjcvLys4?=
 =?utf-8?B?QXlwbitHaGRuakMzOUkvL2VhYkhvUXN6eVJxZm82U0VXSnlSanB3MTJCOVV5?=
 =?utf-8?B?c3RRa1pXV1RYeTFmWGRuY3NybHpqQnlWTnllSnpzYkYwY1pYTTBzU29oeTli?=
 =?utf-8?B?NExjcVlrOWhzamtYdzBmdnU2Q1NCTUFuMktaa0h1d1FUcXB6MTdEVytwYXM1?=
 =?utf-8?B?MVA3RE11c0g2aVo1clg5Qkw4RXZCQ3htYm5PZlB2NFZtMWMxY25pSlEwTlpD?=
 =?utf-8?B?ZDNtZityeVlFMHpjcDArdmhXQWpGSXI0LzBRVE9FVm1NVjhOSUppb0xIUkxs?=
 =?utf-8?B?bXhPNVdLT1p4WmxCWUV5cFlWT3p2Rm9WdjBPc2NjSGZocVZmck44aXY1bVBB?=
 =?utf-8?B?SmdrU0Y0cVB1elMwdTVxSm9RUlFwaGxVSVVxNnlONjBaTTJrWThMcXgwOUdQ?=
 =?utf-8?B?OE5td1F6TGNwbEhEbVc4UWJWQmIrVFdHVzVoVTFEQ1NVQnp6NnRGc1NDZ0lF?=
 =?utf-8?B?b3NieFVZUUdHcHZpdEI5Yno1UGlHeFlSc0Y4WUZsSXp0OFJMYTNWb3ZMKzhD?=
 =?utf-8?B?d25pWWR2RlNod3V6L1FIeUJPTXphU0d3TWRqYlpiTjhZb0pHYTdJcXdkanMw?=
 =?utf-8?B?bTZDWDlSTmI2NVE3RVNvNWhJd0paRDAwM1BIeHlYZGJGUFlrVjN1K1MwemY0?=
 =?utf-8?B?UWhmQUZOazNuT2R4bERGWUM5ZVZnTWZ4NzJvU1doWDFySk52ZzV6UXJuRXEv?=
 =?utf-8?B?bjhCVVo5NDlZaTF0aVI1Q2lhZ1BPWC9lLzFVQlFWRWxiVm53UDA5SUhFWlRp?=
 =?utf-8?B?bjRlNjlQN3V5b2FKNVlSUDhtdkZxR0xvRmJPMXRZSm9pOFEzRTduSS9zaHB1?=
 =?utf-8?B?ZzJYSWFQUTU1R0twTHBPRFRjS2JhcXJ4RXZPNVdramNBK2ViSGRVMmhXZ0Jq?=
 =?utf-8?B?cTJRSFdYak9RSWd2Wjk1TjNiVFNaYm9qcFFGSnFvMFgwd0ZNc2pvM3pLMTJU?=
 =?utf-8?B?Zng3dTJXZ2tsTllpaDhLOWJHZzJRQXRYTTZqbjRqQnFlZW83a2tRZnV4djVM?=
 =?utf-8?B?clg4Z3doMXhVR3NrdmYxaGdhVnlPWTR1WWxhVjhkZk0zYk1IZzNNSlpCUlZ0?=
 =?utf-8?B?aEY3QzZUekVYcWlZL1VRUVphTy9qUy9paGV1a2hVL0VROUtoQTNYZGZzc0Zq?=
 =?utf-8?B?ejI2RjV6eUI4RzA1cVovYnJ6eXg4bGgyMVFmK2R4MEEvdFV6dz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3098db-3472-47da-7a1b-08daf366dbdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 00:00:32.6791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p8pZkJyYhAJhhmurnACRjoSNvd27ioSUkuGljmQg1iLmQ1Ecd3SphUHq8KNRr73JOJC5UuImpUtryMQe3TIDVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032
X-Proofpoint-ORIG-GUID: GPBUAJ1DegzYUNtLxGS-IsaNBNSf4n-X
X-Proofpoint-GUID: GPBUAJ1DegzYUNtLxGS-IsaNBNSf4n-X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=392 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKYW4gMTAsIDIwMjMsIExpbnl1IFl1YW4gd3JvdGU6DQo+IA0KPiBPbiAxLzEwLzIw
MjMgMTE6MTMgQU0sIExpbnl1IFl1YW4gd3JvdGU6DQo+ID4gDQo+ID4gT24gMS8xMC8yMDIzIDEx
OjA1IEFNLCBMaW55dSBZdWFuIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBPbiAxLzEwLzIwMjMgMTA6
NTMgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+ID4gT24gVHVlLCBKYW4gMTAsIDIwMjMs
IExpbnl1IFl1YW4gd3JvdGU6DQo+ID4gPiA+ID4gT24gMS8xMC8yMDIzIDI6MjggQU0sIFRoaW5o
IE5ndXllbiB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIEZyaSwgSmFuIDA2LCAyMDIzLCBMaW55dSBZ
dWFuIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBPbiAxLzUvMjAyMyA1OjU0IFBNLCDsoJXsnqztm4gg
d3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
ID4gPiA+ID4gPiA+ID4gRnJvbTogTGlueXUgWXVhbiBbbWFpbHRvOnF1aWNfbGlueXl1YW5AcXVp
Y2luYy5jb21dDQo+ID4gPiA+ID4gPiA+ID4gPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSA1LCAy
MDIzIDEyOjM1IFBNDQo+ID4gPiA+ID4gPiA+ID4gPiBUbzogSmFlSHVuIEp1bmc7IEZlbGlwZSBC
YWxiaTsgR3JlZyBLcm9haC1IYXJ0bWFuOyBUaGluaCBOZ3V5ZW4NCj4gPiA+ID4gPiA+ID4gPiA+
IENjOiBvcGVuIGxpc3Q6VVNCIFhIQ0kgRFJJVkVSOyBvcGVuIGxpc3Q7DQo+ID4gPiA+ID4gPiA+
ID4gPiBTZXVuZ2NodWxsIFN1aDsgRGFlaHdhbiBKdW5nDQo+ID4gPiA+ID4gPiA+ID4gPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSB1c2I6IGR3YzM6IENsZWFyDQo+ID4gPiA+ID4gPiA+ID4gPiBEV0Mz
X0VWRU5UX1BFTkRJTkcgd2hlbiBjb3VudCBpcyAwDQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gT24gMS81LzIwMjMgMTE6MjkgQU0sIExp
bnl1IFl1YW4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIDEvMi8yMDIzIDE6MDggUE0s
IEphZUh1biBKdW5nIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNvbWV0aW1lcyB2ZXJ5
IHJhcmVseSwgVGhlIGNvdW50IGlzDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gMCBhbmQgdGhlIERX
QzMgZmxhZyBpcyBzZXQgaGFzDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gc3RhdHVzLg0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IEl0IG11c3Qgbm90IGhhdmUgdGhlc2Ugc3RhdHVzLg0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IEJlY2F1c2UsIEl0IGNhbiBtYWtlIGhhcHBlbg0KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IGludGVycnVwdA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHN0b3JtaW5nIHN0YXR1cy4N
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gY291bGQgeW91IGhlbHAgZXhwbGFpbiB3aXRob3V0IGNsZWFy
IHRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiBmbGFnLCBob3cgaW50ZXJydXB0IHN0b3JtaW5nDQo+
ID4gPiA+ID4gPiA+ID4gPiA+IGhhcHBlbiA/DQo+ID4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gPiA+ID4gPiBhcyB5b3VyIGNoYW5nZSBkaWRuJ3QgdG91Y2ggYW55IGhhcmR3YXJlDQo+
ID4gPiA+ID4gPiA+ID4gPiA+IHJlZ2lzdGVyLCBpIGRvbid0IGtub3cgaG93IGl0DQo+ID4gPiA+
ID4gPiA+ID4gPiA+IGZpeCBzdG9ybWluZy4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiA+ID4gSC9XIGludGVycnVwdHMgYXJlIHN0aWxsIG9jY3VyIG9uIElQLg0KPiA+ID4gPiA+
ID4gPiBJIGd1ZXNzIHdlIHNob3VsZCBmaXggaXQgZnJvbSBJUCBsYXllci4NCj4gPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiBIb3cgYXJlIHlvdSBjZXJ0YWluIHRoZSBwcm9ibGVtIGlzIGZyb20g
SVAgbGF5ZXI/DQo+ID4gPiA+ID4gSSB0aGluayBhbGwgSVJRIGlzIGZyb20gRFdDMyBjb250cm9s
bGVyIElQLiBpZiBpdCBpcyBub3QgSVANCj4gPiA+ID4gPiBsYXllciwgY291bGQgeW91DQo+ID4g
PiA+ID4gc2hhcmUgaG93IHRvIHByZXZlbnQgZnJvbSBTVyBsYXllciA/DQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gc2VlbSBJUlEgY2FuIGhhcHBlbiB3aGVuIGV2ZW50IGNvdW50IGlzIHplcm8gLMKg
IHdoeSB0aGlzIGNhbg0KPiA+ID4gPiA+IGhhcHBlbiA/IGRvZXMNCj4gPiA+ID4gPiBpdCBtZWFu
IGV2ZW50IGNvdW50IHJlZ2lzdGVyIGlzIG5vdCB0cnVzdCA/DQo+ID4gPiA+IFdoZW4gdGhlIGlu
dGVycnVwdCBpcyB1bm1hc2tlZCwgdGhlIGNvbnRyb2xsZXIgd2lsbCBnZW5lcmF0ZSBpbnRlcnJ1
cHRzDQo+ID4gPiA+IGFzIGV2ZW50cyBhcmUgcmVjZWl2ZWQuIE5vcm1hbGx5LCB0aGUgZmxhZyBj
aGVja2luZyBmb3IgcGVuZGluZyBldmVudA0KPiA+ID4gPiBzaG91bGQgYmUgY2xlYXJlZCBiZWZv
cmUgdW5tYXNraW5nIHRoZSBpbnRlcnJ1cHQsIGJ1dCB3ZSBjbGVhciBpdCBhZnRlcg0KPiA+ID4g
PiB0byBhY2NvdW50IGZvciBwb3NzaWJsZSBmYWxzZSBpbnRlcnJ1cHQgZHVlIHRvIHRoZSBuYXR1
cmUgb2YgbGVnYWN5IHBjaQ0KPiA+ID4gPiBpbnRlcnJ1cHQuIFRoaXMgZXhwb3NlcyBhIGdhcCB3
aGVyZSB0aGUgaW50ZXJydXB0cyBjYW4gY29tZSBidXQNCj4gPiA+ID4gdGhlIGZsYWcNCj4gPiA+
ID4gaXNuJ3QgY2xlYXJlZC4gV2hpbGUgaXQgc2hvdWxkIGJlIHJhcmUgYW5kIHNob3VsZG4ndCBi
ZSB0b28gbXVjaCBvZiBhDQo+ID4gPiA+IHByb2JsZW0sIHdlIGNhbiBhdm9pZCB0aGlzIHNjZW5h
cmlvIHdpdGggc29tZSBhZGRpdGlvbmFsIGNoZWNrcy4NCj4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+
IGJ1dCB3aGVuIGNoZWNraW5nIERXQzNfRVZFTlRfUEVORElORyBmbGFnLCBpdCB3aWxsDQo+ID4g
PiA+ID4gPiA+IGF1dG8gY2xlYXIgaW4gZHdjMyB0aHJlYWQNCj4gPiA+ID4gPiA+ID4gaXJxIGhh
bmRsZXIuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiB0aGVyZSBpcyBvbmUgcG9zc2li
bGUgcm9vdCBjYXVzZSBpcyBpdCBjbGVhcmVkIG9ubHkNCj4gPiA+ID4gPiA+ID4gYWZ0ZXIgaXJx
IGVuYWJsZWQgaW4NCj4gPiA+ID4gPiA+ID4gZHdjM19wcm9jZXNzX2V2ZW50X2J1ZigpLA0KPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gd2Ugc2hvdWxkIG1vdmUgdW5tYXNrIGlycSBvcGVy
YXRpb24gYXQgZW5kIG9mIHRoaXMgZnVuY3Rpb24uDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gVGhpcyBpbnRlcnJ1cHQgc3Rvcm0gY2FuIGhhcHBlbiBiZWNhdXNlIHdlIGNsZWFyIHRoZQ0K
PiA+ID4gPiA+ID4gZXZ0LT5mbGFncyBfYWZ0ZXJfDQo+ID4gPiA+ID4gPiB3ZSB1bm1hc2sgdGhl
IGludGVycnVwdC4gVGhpcyB3YXMgZG9uZSB0byBwcmV2ZW50IGZhbHNlDQo+ID4gPiA+ID4gPiBp
bnRlcnJ1cHQgZnJvbQ0KPiA+ID4gPiA+ID4gZGVsYXkgaW50ZXJydXB0IGRlYXNzZXJ0aW9uLCB3
aGljaCBjYW4gYmUgYSBwcm9ibGVtIGZvciBsZWdhY3kgcGNpDQo+ID4gPiA+ID4gPiBpbnRlcnJ1
cHQuDQo+ID4gPiA+ID4gdGhhbmtzIGZvciBleHBsYWluLCBpIGRpZG4ndCBrbm93IHRoYXQuDQo+
ID4gPiA+ID4gPiBzZWUgNzQ0MWIyNzMzODhiICgidXNiOiBkd2MzOiBnYWRnZXQ6IEZpeCBldmVu
dCBwZW5kaW5nIGNoZWNrIikNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhlIGNoYW5nZSBK
YWVIdW4gSnVuZyBkaWQgc2hvdWxkIGJlIGZpbmUuDQo+ID4gPiA+ID4gYWdyZWUuDQo+ID4gPiA+
IFRoZSBjaGFuZ2UgbWF5IHN0aWxsIG5lZWQgc29tZSBhZGRpdGlvbmFsIGNoZWNrIGFzIHN1Z2dl
c3RlZCBpbiBteQ0KPiA+ID4gPiByZXNwb25zZToNCj4gPiA+ID4gaHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8yMDIzMDEwOTE5MDkx
NC4zYmxpaGpmamRjc3phemRkQHN5bm9wc3lzLmNvbS9ULyptN2I5MDdhYTZkYTQwMjNjYjIwZmEw
MGE1NzgxM2QzMWZkODRlMDgxZl9fO0l3ISFBNEYyUjlHX3BnIWRjaGMwVUFlWm5tN1BjQS1hYXZf
NThyc3c3YWdNeWd3UFNHQ19rTjhHYV9CUzNvVGJMTU5oM0RrZlE5QjJuamJ2YS10SnpUajdDYjJk
Sm5FNVJiRVc2S0puRG10RkEkDQo+ID4gPiA+IA0KPiA+ID4gwqBkbyB5b3UgdGhpbmsgd2UgbmVl
ZCB0byByZWFkIGV2ZW50IGNvdW50IGJlZm9yZSBjaGVja2luZw0KPiA+ID4gRFdDM19FVkVOVF9Q
RU5ESU5HwqAgPw0KPiA+IHNvcnJ5IGZvciB0aGlzIG5vaXNlLCBtYXkgYmUgaSBoYXZlIGEgbGl0
dGxlIHVuZGVyc3RhbmRpbmcgb2YgdGhlIGxlZ2N5DQo+ID4gcGNpIGlzc3VlIG5vdy4NCj4gb25l
IG1vcmUgcXVlc3Rpb24sIGlzIGl0IGxlZ2FjeSBQQ0llIGRldmljZSBzdGlsbCBleGlzdCBpbiBy
ZWFsIHdvcmxkID8gYW5kDQo+IGFueSBWSUQvUElEIGluZm8gPw0KDQpDdXJyZW50bHksIGFsbCBk
d2MzIFBDSWUgZGV2aWNlcyBhcmUgYWZmZWN0ZWQuIFNvbWUgc2V0dXBzIGFyZSBtb3JlDQpub3Rp
Y2VhYmxlIHRoYW4gb3RoZXJzLiBUaGUgZHdjMyBkcml2ZXIgaXMgaW1wbGVtZW50ZWQgdG8gcHJv
YmUgcGxhdGZvcm0NCmRldmljZXMuIFNvLCBkd2MzIFBDSWUgZGV2aWNlcyBhcmUgd3JhcHBlZCBh
cyBwbGF0Zm9ybSBkZXZpY2VzIGZvciB0aGUNCmR3YzMgZHJpdmVyLiBTaW5jZSB3ZSdyZSBnb2lu
ZyB0aHJvdWdoIHRoZSBwbGF0Zm9ybSBkZXZpY2UgY29kZSBwYXRoLA0KdGhlIHBjaSBsYXllciBm
YWxscyBiYWNrIHRvIHVzaW5nIGxlZ2FjeSBpbnRlcnJ1cHQgaW5zdGVhZCBvZiBNU0kgKGxhc3QN
CkkgY2hlY2sgYXdoaWxlIGFnbykuDQoNCkEgbGl0dGxlIG1vcmUgZGV0YWlsIG9uIHRoaXMgcHJv
YmxlbToNClBDSWUgbGVnYWN5IGludGVycnVwdCB3aWxsIGVtdWxhdGUgaW50ZXJydXB0IGxpbmUg
Ynkgc2VuZGluZyBhbg0KaW50ZXJydXB0IGFzc2VydCBhbmQgZGVhc3NlcnQgbWVzc2FnZXMuIEFm
dGVyIHRoZSBpbnRlcnJ1cHQgYXNzZXJ0DQptZXNzYWdlIGlzIHNlbnQsIGludGVycnVwdHMgYXJl
IGNvbnRpbnVvdXNseSBnZW5lcmF0ZWQgdW50aWwgdGhlDQpkZWFzc2VydCBtZXNzYWdlIGlzIHNl
bnQuIElmIHRoZXJlJ3MgYSByZWdpc3RlciB3cml0ZSB0byB1bm1hc2svbWFzaw0KaW50ZXJydXB0
IG9yIGNsZWFyaW5nIGV2ZW50cyBmYWxscyBpbiBiZXR3ZWVuIHRoZXNlIG1lc3NhZ2VzLCB0aGVu
IHRoZXJlDQptYXkgYmUgYSByYWNlLg0KDQpMZXQncyBzYXkgd2UgZG9uJ3QgaGF2ZSBldmVudCBw
ZW5kaW5nIGNoZWNrLCB0aGlzIGNhbiBoYXBwZW46DQoNCk5vcm1hbCBzY2VuYXJpbw0KLS0tLS0t
LS0tLS0tLS0tDQogICAgZXZlbnRfY291bnQgKz0gbiAjIGNvbnRyb2xsZXIgZ2VuZXJhdGVzIG5l
dyBldmVudHMNCiAgaW50ZXJydXB0IGFzc2VydHMNCiAgICB3cml0ZShtYXNrIGlycSkNCiAgICBl
dmVudF9jb3VudCAtPSBuICMgZHdjMyBjbGVhcnMgZXZlbnRzDQogIGludGVycnVwdCBkZWFzc2Vy
dHMNCiAgICB3cml0ZSh1bm1hc2sgaXJxKQ0KDQoNClJhY2Ugc2NlbmFyaW8NCi0tLS0tLS0tLS0t
LS0NCiAgICBldmVudF9jb3VudCArPSBuICMgbmV3IGV2ZW50cw0KICBpbnRlcnJ1cHQgYXNzZXJ0
cw0KICAgIHdyaXRlKG1hc2sgaXJxKQ0KICAgIGV2ZW50X2NvdW50IC09IG4gIyBjbGVhciBldmVu
dHMNCiAgICBldmVudF9jb3VudCArPSBuICMgbW9yZSBldmVudHMgY29tZSBhbmQgaGFyZCBpcnEg
aGFuZGxlciBnZXRzIGNhbGxlZA0KCQkgICAgICMgYWdhaW4gYXMgaW50ZXJydXB0IGlzIGdlbmVy
YXRlZCwgYnV0IGNhY2hlZA0KCQkgICAgICMgZXZlbnRzIGhhdmVuJ3QgYmVlbiBoYW5kbGVkLiBU
aGlzIGJyZWFrcw0KCQkgICAgICMgc2VyaWFsaXphdGlvbiBhbmQgY2F1c2VzIGxvc3QgZXZlbnRz
Lg0KICAgIHdyaXRlKG1hc2sgaXJxKQ0KDQogICAgZXZlbnRfY291bnQgLT0gbiAjIGNsZWFyIGV2
ZW50cw0KICBpbnRlcnJ1cHQgZGVhc3NlcnRzDQogICAgd3JpdGUodW5tYXNrIGlycSkgIyBldmVu
dHMgaGFuZGxlZA0KDQoNCkZvciBNU0ksIHRoaXMgd29uJ3QgYmUgYSBwcm9ibGVtIGJlY2F1c2Ug
aXQncyBlZGdlLXRyaWdnZXJlZCBhbmQgdGhlIHdheQ0KaXQgc2VuZHMgaW50ZXJydXB0IGlzIGRp
ZmZlcmVudC4NCg0KQlIsDQpUaGluaA==
