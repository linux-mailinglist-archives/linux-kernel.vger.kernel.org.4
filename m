Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F3A6CF7FF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 02:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjC3ALI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 20:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjC3ALG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 20:11:06 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB1965B4;
        Wed, 29 Mar 2023 17:10:50 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TJe2Bq016679;
        Wed, 29 Mar 2023 17:10:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=JKOoZDtb0xXlNIbizS4vzQcc+iQKv/j23MtOtL+Od8U=;
 b=lE8yS7p6pC4lElWuD1HLmMcQ2jtK/Bvp/fxCkfyALESdwL3DMrQ1Q9JXFPeIqrZwrYSz
 ZeZ4LSSnlyQsuFzqiiSiDlm/H4KShTY3Z/T5nmMsrH4HCQQai2euDHmL2lgI3rWr1gGN
 2LZvd5o9B0RqWOSXP6LHztD95vx+MR0npixW4sY5T3xzXSImBBDwTchdkk5rp90q6jgQ
 VQzUD56wkVfxCNcR8Z+58SVDuaK0iQx1tU1C79jjyNJcC3qXbAWjG7VERsjad9sRR7ta
 dlf1FlNz5x7zqLhjUiRAjfDJCMp2+1TQD9CPFm/Y/ERJyZs2OdXckOtAVvrMfWxd4gpP 9w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pj076xxr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:10:21 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 143DFC04C3;
        Thu, 30 Mar 2023 00:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680135020; bh=JKOoZDtb0xXlNIbizS4vzQcc+iQKv/j23MtOtL+Od8U=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RA/BOC6Y9mxJEauDlRk/ZOBbbfwC1nleB2Xn3rj0FN9olFipy1F8KeZpq1expv/rq
         YIeJ2JcJnWFpblTGRFMfLEnN4v5Ip6seE+x2jHZ9kHWsUbDXItmwvtX8O7/jdjDkcN
         U5Y50tkGFdln09a98ysxIbxPB0HGtSJNoqurt+GRPB4tH5nAS6JIhjEYjaH/zsu5t3
         MOIQMvAwof7grnSOFtSet9on9U9EhjXkpIaMR0cxxJvgka2s+79DySRi6vFMj97B+x
         PEM3CvUxTnQzEqSWCmn/EccYG67d0WWZv7TtfbJ8tWRNy2CldO0kh+Y8nBRodIIRoc
         h721DqeCETQXQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0896BA006D;
        Thu, 30 Mar 2023 00:10:17 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 46DA94006C;
        Thu, 30 Mar 2023 00:10:16 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="fBauDj01";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deCbCokHw2w1wuNxIEvcrzop6rSUr+Mdoime1iVSa5OvuNiChEqWZjc4Hstnnz/F+yF/uOYKxN+ULygm98Xj2X1Xvqw8xibqvUOvgwHE20/G8vhsYnFa7Rds5vksm0uemfs61o+erM/FQoMhiCyUS9y9Xbzb8+29HxTmrhzV7K+jenIAdDUKkYiGC/b3CVWBl90hCL7qb2JwVYip61NaRm7S+4TKuM/yS3RQLVSCS4b2i4Dwcl5TLbn0OumLUIC2R8N26EVnmxCU6qbL3Qj92wLUOkYxNPh2QluHeufS+YkggRwEGIJYJpYFpFqNcc/mN2+O2r7ioin+nhI3E89NCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKOoZDtb0xXlNIbizS4vzQcc+iQKv/j23MtOtL+Od8U=;
 b=JtIdTMMPzp9IFcF95qcg0OTPa0x/7Nd20ByYS8UXGK0R9IWnaZSUY4NbydAqvbZa1htRWLi/eEJpbHb1bb6TFmOQkvL8JUVdkHnEBm0C/8/KHdafQZWWqNvMeEAFF9yvOf0v1jZU5f57CqEo0Ag7Glxjd2S8EIJm3JLagIwbosCP9Trqi776Ormuye3yhedylIl35ovrdvJoF/WnIkfhvF2yWebLG/mnXAvyG96kERmoAOwCIpP94wQSJPzz+5ZiCm57/zzLAyOckNJZng84TG08iFS+PA9ceQHTPlUIQOkZBS/CAAPbdTG3bDYU7lY4X2quPgx771lg2LKm+32SSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKOoZDtb0xXlNIbizS4vzQcc+iQKv/j23MtOtL+Od8U=;
 b=fBauDj01+ZVS46x6x1iTfD0j+e5HBihRDHz3jM2T8XZQSYdjey61nTjK1oh4l9HZz5Dk/3CsTcJqYrC1yW94Cs5Ly3QC4NXqz2vVePLsGM2+o0jniU5Fsi5UxXR9bKa1TvShBUdMQ4ViYdEqeQxHLauP+csHEVoIikfac4mvlmM=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ2PR12MB8034.namprd12.prod.outlook.com (2603:10b6:a03:4c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Thu, 30 Mar
 2023 00:10:11 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 00:10:11 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jiantao Zhang <water.zhangjiantao@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3: gadget: Bail out in pullup if soft
 reset timeout happens
Thread-Topic: [PATCH v2 1/2] usb: dwc3: gadget: Bail out in pullup if soft
 reset timeout happens
Thread-Index: AQHZYY+ZaTJWoGmlmk+xC9kJuoh9G68QszUAgAB5QYCAAUhdgA==
Date:   Thu, 30 Mar 2023 00:10:11 +0000
Message-ID: <20230330001003.rwzo4n2hl6i22vh3@synopsys.com>
References: <20230328160756.30520-1-quic_kriskura@quicinc.com>
 <20230328160756.30520-2-quic_kriskura@quicinc.com>
 <20230328212048.rpm4ly265etahwm3@synopsys.com>
 <0aa1caae-ab09-2ef9-0ec8-3dd01a3f3af0@quicinc.com>
In-Reply-To: <0aa1caae-ab09-2ef9-0ec8-3dd01a3f3af0@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ2PR12MB8034:EE_
x-ms-office365-filtering-correlation-id: 75006643-4b03-4a10-960d-08db30b320e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PgaNszqmbg8yXzmeJsi0WnuaNJ83EJtPGxFI9YIb6KmMI25+p0OKM1TgJv9j7l41bVJXrV+mgGzf4TMxe3yAXSj136QIbHQlBHe52jDZTh7KQPj/gMwtWCAUXuuveXIk/IqETSELqfsVGhj4JL7i8V5g0IOhUFovZvXDEIb1SmdvrvNcj82T+Uh2p96ilZCqQVSbOqzj1SNcuRRf45Ji2f7c/eRGR/FdsImBwY7IX29Z1ourz1jgbKBSDGgBEdUnY4YvtpJGhZo6uSE36d+9gCocrHLTPmZWlRLIxSZyDDK95vRE27pVihqTUTM1ic41XSOGQEkZDSOCjEmBHgjhEbw/3U8ClYfXg9TaGuBhMcprjGLKCbs0gYrKP85K7gQmQW6w3J1DswlUZEeyC7GxyvShz6+7Qu2QZk+YiEiJeT6HxiS4+WkhA2mI8EOPfyRjabaT/dzIhn6FxhUKi407p8cIWrZtubrlPBKMaqpkN7Xkk1aJlfAC56u5EjVZ3L/bTsN5zEIAmSswrZnJRJsXxg5PWQ9OOs5mvSxE5U+2IXcvVtygwQnHDtc7Ygp8lEX++DPuoCnXnCdsoAgiI4MLW95a/ETf6hYYnoMuthFnzD2hAmOY7h9Fgtm1xwkXnaed
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199021)(64756008)(86362001)(38070700005)(478600001)(71200400001)(186003)(66556008)(41300700001)(6506007)(1076003)(26005)(36756003)(38100700002)(8936002)(122000001)(6512007)(83380400001)(316002)(5660300002)(7416002)(6916009)(8676002)(4326008)(76116006)(66946007)(54906003)(6486002)(66476007)(2616005)(66446008)(2906002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2lsbjNkOGQzWU5Dc2pkSlEwM25NWmhBN0E1S0R0Y0w1Nk9ySzB0ZW1ta0dT?=
 =?utf-8?B?MkpLRmlIU2MxdWlicklyUXF5SUpFRXFCMHR0eGlTVm5qeUdQczNTRXRuZDRa?=
 =?utf-8?B?b0pIMzhFRVZlUkxFR090cnNJUFlFVmhNcHV2bFVOSmhFcFVaQkNHd0hnMkRa?=
 =?utf-8?B?MTRVOUR4dDhObFJ5Vnh6ZnpxbzdZMkJ2R25XRUxyWDNsVzJqSEZGS1NKdUpI?=
 =?utf-8?B?TUJUUHN6OGFJWWRnRElHM3VqWEJVaWpyelZQSzA3OXpZOXJkL1dYcTYxTk5t?=
 =?utf-8?B?OGdjK2p1M2JraUNwbXhJb1NJUHIrOWptSkxWQmFQU0ZrUGZEcWM4cDdMWnJp?=
 =?utf-8?B?d2FMYkwya2V6djhnSEdNZnlzUzBwMVFNdXU3bEYxVFlFcEN0MkNJbFhjN1Mw?=
 =?utf-8?B?WWt2czdBSmZJWFpQNGF1aVBYUzR0aW9KVTdvWDBDZFNTamRuTDg2dTg3dCtw?=
 =?utf-8?B?SEx6bk42SjgwYUJSVi93bXM0N0tBUEY2NjVnSkk3aTYvK01kVFlPUzA5NFVI?=
 =?utf-8?B?NXkwVlU3czRQbFJoL2VMVktuTnh4WTI3cERTL1BiVFphWm5oQUtRNXJPd09G?=
 =?utf-8?B?b3A1WHNyZHROVm5FMVp1TE1ZdVVkaHNyQ3VPTGpIQVJsRWRSQTVJaHdWL083?=
 =?utf-8?B?ek9IbnNza0RUaGd1d01rWUgyS3ExYUhmUHI1OTZ5c0V6bGMzUTZVR1hCZGpx?=
 =?utf-8?B?TUxwQ0pqQ3VFbGF0czd2K0tsVVZaN1ZNRGE4OVc3U3c1WStidzZySWpWc0ov?=
 =?utf-8?B?NUhZaFFkb1A3djdTRi9Yd3NyRTU1d1U4TnNYTWZFM1JyeEhqS1hlM2lyQSsv?=
 =?utf-8?B?VUxrNzIxb1NaQ3J2WWM1ZnllRnhRZWRIRklxYjVGNTgwNHRHbERKKzl1UHJZ?=
 =?utf-8?B?UTN1anpUWHZZc2M4TnhramRlODFBRGhvaXYyT1U2VHExMWhVL2ZlNlRxT1dz?=
 =?utf-8?B?ckY5OHRDb1Y1Slo4VXFyT0NDczlnb0RhV0FkbW84MnpsR1BjNkNpeU9HQjBi?=
 =?utf-8?B?Nk52dnpIUWE1dHBEd2JmNEdDdVp6MzFhQ0FDMUF5Rkx6QmhPSDFVd09zRG1S?=
 =?utf-8?B?UURQN3Z3dDRCRkg0ZW9TV3k0Z0tmTkVjbDY3eFZtL01kN1pDVTNyWVFvTGRF?=
 =?utf-8?B?TEhDNGdSR1hoMi9hVTRCVkkyMXRMdTdoMTRjN2Q0OGl0eWFadVBxb1ZaMGNx?=
 =?utf-8?B?NTV3TEJLdmhnKzlaRktSblh1NmQ3MXc5Qk9uOFJyRTB5QVBLeVF6eXo3aEow?=
 =?utf-8?B?UjFXYUxwVGRkaXRTSmtrUjg1aG9yOGVKOEFxV2NXUE5Hdjd5UG9ta00rV0hV?=
 =?utf-8?B?MURSNUVyMmNwSmwrcW00K3dLSWtHb3JLcyttUmZlNzRGK25HRkdsL3ZNRXJI?=
 =?utf-8?B?RS85UXR6K245MXpleUEzMzZpT0tZWjdzYWpwcC93K0V0WnVzUnZ3K3JUVTA1?=
 =?utf-8?B?VGNqcXJlZXE4WnR5M2JvQ21lczBTMFFuNnI1RStPVXhGenNmenluaDhtTVdL?=
 =?utf-8?B?a1NtR0kyNnkzM09iN21ra1dlQlVWQ0NyVDFMb3VkM3JpNHlGU29QbnZWUkl6?=
 =?utf-8?B?RFR1NWhaV1AxT3AxQ3ZBc3Y5UTgrYk9OdC95R2QzNGpDaXE0T3JCNm1aUHQ4?=
 =?utf-8?B?SXFHVFZGQU5FRHI5eDAwSzc4ZDR3M0pMOEIwaW9QOE1XbVJlUW1iOGJNS2pW?=
 =?utf-8?B?N3FsWXREdFl1dmVibnN6VEtOUThUZHhDVmlhb1oxUis5Q1hETzZHSWZEOHIy?=
 =?utf-8?B?WlhVL0MwZVRnM1dZcy9rZDRmRGFaWkZIZURGbnlqNlF0NzlRVGkveU9nTGlJ?=
 =?utf-8?B?WXJua0tZTytSWHE2WkluZjN2MDhVZzgydUgwQ1pkVGtqQ1NVRlo3T2tNZXph?=
 =?utf-8?B?b1RPQlBZQ3BweWE0QWNYOTdDeEphSm5SSjVvSy8waUJrOXhDdjdHWm1RWDN1?=
 =?utf-8?B?dWZLL2hoTWh0Y0VWelNzZ1dhbWxya05NVld4cEVVNUtMNWJaQUlHSE96dU9G?=
 =?utf-8?B?Rm1LYnh6M29XcHFVU3NSMVRZTmZGd3dvK20xVDBCcUltVlY2WHdEdzRqc2s5?=
 =?utf-8?B?SHJHWEdrNmZSYU9JazBINmFGTkZTVXpoelh4YXZjeVF4TjF6L3k4K1VKa3Jp?=
 =?utf-8?B?a2ppVnpQTXlkdGNrRThRcUJETHY3YjRvOXhRaDF4QWNidjIwSlN5MDhva0lr?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04C0EA5EFB3EEC41BE9427BA6C82805D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?V1cySXZVVUpmVUxzWDhsaXRMbTJUYmxlNjdyRk0rMnI0OWNtWUVPUHMxSmEy?=
 =?utf-8?B?ZEd4Q0dMR0l4SGc0Sit6N2NBZHltU1d4V3gwQWF4ekpQSkgwdnFNQU1CYW1N?=
 =?utf-8?B?SkhKdUN3UERLM3V0REhrNHdvWlhFc3d2dGt1U0d5Um9FdjQ5MGN0TC9sYngz?=
 =?utf-8?B?OVRTVFZjMlh6eDArdHBUeG1sZ2cwclVYeGhuRVE1OW5OQmY2SUpnK21TQ3A3?=
 =?utf-8?B?VXhCdTlTSGNqdjZucktySlRNcU9wYkNzRXhmSk9iekc5d2NWY0ZHQTRtS3Vs?=
 =?utf-8?B?VHZEK3dMaUg4My83VWx2WDJCV01pREdsK2ZyeUd4UjBiQzF5ZktYTnYweVMw?=
 =?utf-8?B?T0xlWkM2ZVNHR3NjYjNtYnpjVitKS1B4YzUzVmxHUHlvNGtiWXRQZGMxR3ZL?=
 =?utf-8?B?Y1VEOFFqQ1VLcFh2eXYrVlRoN0tOclljUHcvcnVpU09xY2RaTEMzbXd3YnE2?=
 =?utf-8?B?ZnZLekp0MmtQZGJSVC9UTWNkZ3ZkVnJDQy9QaW1zQ0N4S0dGdklmajVPeDk2?=
 =?utf-8?B?SStsVnJlUm1SOWRqbG1ZMU9qVjhEQ25ZSFRaSElkN0UyOUFTOTFhL3dMYVQz?=
 =?utf-8?B?dnQ5b2RGaEZLSUYvb0dyN25nSEdXbEZIdkVNZllEOFA0U1BPa1hoTXhGYTRx?=
 =?utf-8?B?eTl2RE81N0dpZTROZ0FvZ2dqcWVjMGh6REZjMVU1WFJMQ3BscDRERGNjYy9u?=
 =?utf-8?B?RTlFM0E4NzUyTG9RWEl4YmVycFZKTXZyTjUwK3FwZE0vOVBGSWJsRkFOdktm?=
 =?utf-8?B?M2tTeFVab3gyTUg2WTBrWmFwc2VVZWtTMWh6RlpkcDVJVm92bjdrdG5GcjJT?=
 =?utf-8?B?djFLeTlSR25TU2ZrajNyVDkva2IxNUo1bzhGY3RzbTZuV3FNSW93MlpQSEY3?=
 =?utf-8?B?UDVFZHNVUlUxdnp3bVcydGl2ZWhlN056N0JON1dXUVhOb3k0RE1zZzFZUVNR?=
 =?utf-8?B?eExzbTlwWUhQejB2UVY3L1lEYU1PUnhoVmtPa0pjQjRsdndkOWxHdmRKNEJS?=
 =?utf-8?B?NlBKdnJzMGkwL0o2SmFkR1NQYVBTZ2VZNTcxTVVnZHRwN0FIMWRtUXFZb3VD?=
 =?utf-8?B?ZkFRWGs1V1ZNalR2dzMraWtPcy80WHR5TGdQNGVsRkgwZ05RS0pnSUR0dFRX?=
 =?utf-8?B?QUlrbzBwUE1Pb25DOHVxWHRkT2x5VlBYSjdyVGdPSjA1aFNDU3gwR0dnSkFy?=
 =?utf-8?B?SmtOd1VWODBmeC9jNW4zdGI2cGJzb2xwSG1rYm16ZFBKODI4MGtFTXVqQUdD?=
 =?utf-8?B?R3FiaEZkVEZEMkMvUmtWVHMyYU5QUHllUWxvM3pob2dPSmlMQUJWZXRiTjNx?=
 =?utf-8?B?Y1pCa0RaUExqcHpsaUF5NmFJelRjRUNnUndRZFVTQ1g5WGZyUWppSGN5N3lN?=
 =?utf-8?B?LzZZSW9WWG9xM0RoSUdrRjRQS2NQTGtqMFBnTTIyNU43Q1hOd0xTNDB0bktU?=
 =?utf-8?Q?cEJVa3z4?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75006643-4b03-4a10-960d-08db30b320e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 00:10:11.1976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EiEKrzH133qEsn+Rn3NpvdTEnI/iKvMPlPuKe6P5SUwmSG+aeYHMcQaA4WGtqciNI8nOPm/VxzO2+awEysiZXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8034
X-Proofpoint-GUID: 42p8KKMGQv4l2_ntWC4ntqAzzVlP9WdX
X-Proofpoint-ORIG-GUID: 42p8KKMGQv4l2_ntWC4ntqAzzVlP9WdX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_14,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303290180
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXIgMjksIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gMy8yOS8yMDIzIDI6NTAgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBIaSwN
Cj4gPiANCj4gPiBPbiBUdWUsIE1hciAyOCwgMjAyMywgS3Jpc2huYSBLdXJhcGF0aSB3cm90ZToN
Cj4gPiA+IElmIHRoZSBjb3JlIHNvZnQgcmVzZXQgdGltZW91dCBoYXBwZW5zLCBhdm9pZCBzZXR0
aW5nIHVwIGV2ZW50DQo+ID4gPiBidWZmZXJzIGFuZCBzdGFydGluZyBnYWRnZXQgYXMgdGhlIHdy
aXRlcyB0byB0aGVzZSByZWdpc3RlcnMNCj4gPiA+IG1heSBub3QgcmVmbGVjdCB3aGVuIGluIHJl
c2V0IGFuZCBzZXR0aW5nIHRoZSBydW4gc3RvcCBiaXQNCj4gPiA+IGNhbiBsZWFkIHRoZSBjb250
cm9sbGVyIHRvIGFjY2VzcyB3cm9uZyBldmVudCBidWZmZXIgYWRkcmVzcw0KPiA+ID4gcmVzdWx0
aW5nIGluIGEgY3Jhc2guDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgS3Vy
YXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICAgZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDUgKysrKy0NCj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMN
Cj4gPiA+IGluZGV4IDNjNjNmYTk3YTY4MC4uZjA0NzI4MDFkOWE1IDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+ID4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPiA+ID4gQEAgLTI2MjAsMTMgKzI2MjAsMTYgQEAgc3RhdGljIGludCBkd2Mz
X2dhZGdldF9wdWxsdXAoc3RydWN0IHVzYl9nYWRnZXQgKmcsIGludCBpc19vbikNCj4gPiA+ICAg
CQkgKiBkZXZpY2UtaW5pdGlhdGVkIGRpc2Nvbm5lY3QgcmVxdWlyZXMgYSBjb3JlIHNvZnQgcmVz
ZXQNCj4gPiA+ICAgCQkgKiAoRENUTC5DU2Z0UnN0KSBiZWZvcmUgZW5hYmxpbmcgdGhlIHJ1bi9z
dG9wIGJpdC4NCj4gPiA+ICAgCQkgKi8NCj4gPiA+IC0JCWR3YzNfY29yZV9zb2Z0X3Jlc2V0KGR3
Yyk7DQo+ID4gPiArCQlyZXQgPSBkd2MzX2NvcmVfc29mdF9yZXNldChkd2MpOw0KPiA+ID4gKwkJ
aWYgKHJldCkNCj4gPiA+ICsJCQlnb3RvIGRvbmU7DQo+ID4gPiAgIAkJZHdjM19ldmVudF9idWZm
ZXJzX3NldHVwKGR3Yyk7DQo+ID4gPiAgIAkJX19kd2MzX2dhZGdldF9zdGFydChkd2MpOw0KPiA+
ID4gICAJCXJldCA9IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKGR3YywgdHJ1ZSwgZmFsc2UpOw0KPiA+
ID4gICAJfQ0KPiA+ID4gK2RvbmU6DQo+ID4gPiAgIAlwbV9ydW50aW1lX3B1dChkd2MtPmRldik7
DQo+ID4gPiAgIAlyZXR1cm4gcmV0Ow0KPiA+ID4gLS0gDQo+ID4gPiAyLjQwLjANCj4gPiA+IA0K
PiA+IA0KPiA+IEkgdGhpbmsgdGhlcmUncyBvbmUgbW9yZSBwbGFjZSB0aGF0IG1heSBuZWVkcyB0
aGlzIGNoZWNrLiBDYW4geW91IGFsc28NCj4gPiBhZGQgdGhpcyBjaGVjayBpbiBfX2R3YzNfc2V0
X21vZGUoKT8NCj4gDQo+IEhpIFRoaW5oLA0KPiANCj4gICBTdXJlLiBXaWxsIGRvIGl0Lg0KPiBX
aWxsIHRoZSBiZWxvdyBiZSBnb29kIGVub3VnaCA/IE9yIHdvdWxkIGl0IGJlIGdvb2QgdG8gYWRk
IGFuIGVycm9yL3dhcm4gbG9nDQo+IHRoZXJlPg0KDQpUaGVyZSdzIGFscmVhZHkgYSB3YXJuaW5n
IG1lc3NhZ2UgaW4gZHdjM19jb3JlX3NvZnRfcmVzZXQoKSBpZiBpdCBmYWlscy4NCg0KPiANCj4g
a3Jpc2t1cmFAaHUta3Jpc2t1cmEtaHlkOi9sb2NhbC9tbnQvd29ya3NwYWNlL2tyaXNobmEvc2th
bGVzMi9za2FsZXMva2VybmVsJA0KPiBnaXQgZGlmZiBkcml2ZXJzL3VzYi8NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4g
aW5kZXggNDc2YjYzNjE4NTExLi44ZDFkMjEzZDFkY2QgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC0y
MTAsNyArMjEwLDkgQEAgc3RhdGljIHZvaWQgX19kd2MzX3NldF9tb2RlKHN0cnVjdCB3b3JrX3N0
cnVjdCAqd29yaykNCj4gICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiAgICAgICAgIGNhc2UgRFdDM19HQ1RMX1BSVENBUF9ERVZJQ0U6DQo+IC0gICAgICAgICAg
ICAgICBkd2MzX2NvcmVfc29mdF9yZXNldChkd2MpOw0KPiArICAgICAgICAgICAgICAgcmV0ID0g
ZHdjM19jb3JlX3NvZnRfcmVzZXQoZHdjKTsNCj4gKyAgICAgICAgICAgICAgIGlmIChyZXQpDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiANCj4gICAgICAgICAgICAgICAg
IGR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cChkd2MpOw0KPiANCg0KSWYgc29mdC1yZXNldCBmYWls
ZWQsIHRoZSBjb250cm9sbGVyIGlzIGluIGEgYmFkIHN0YXRlLiBXZSBzaG91bGQgbm90DQpwZXJm
b3JtIGFueSBmdXJ0aGVyIG9wZXJhdGlvbiB1bnRpbCB0aGUgbmV4dCBoYXJkIHJlc2V0LiBXZSBz
aG91bGQgZmxhZw0KdGhlIGNvbnRyb2xsZXIgYXMgZGVhZC4gSSBkb24ndCB0aGluayB3ZSBoYXZl
IHRoZSBlcXVpdmFsZW50IG9mIHRoZQ0KaG9zdCdzIEhDRF9GTEFHX0RFQUQuIEl0IG1heSByZXF1
aXJlIHNvbWUgd29yayBpbiB0aGUgVURDIGNvcmUuIFBlcmhhcHMNCndlIGNhbiBmbGFnIHdpdGhp
biBkd2MzIGZvciBub3cgYW5kIHByZXZlbnQgYW55IGZ1cnRoZXIgb3BlcmF0aW9uIGZvciBhDQpz
aW1wbGVyIGZpeC4NCg0KVGhhbmtzLA0KVGhpbmg=
