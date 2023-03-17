Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA1A6BF62C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCQXUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjCQXUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:20:19 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F914399C9;
        Fri, 17 Mar 2023 16:20:15 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HLnE09003861;
        Fri, 17 Mar 2023 16:20:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=/ZhMSWRRzhjwWFfIcfiSnAX3OeDbtaMyr5x9TCHJftc=;
 b=ZUJceHPNGTUPFzi/hr/s/anvzHy6Xy7InZQ2WoYZiIpjP/dV1Nq5n+fi2jMVFYfifhXb
 DnryhgeJyv6b0ErketRoc8nlX1+5Kd+F6I7psonPfkfl5ypvmb2670zYQzMY15DSui03
 Db6z0aOe3Fy+0X2Sc8aEyWy4uF78G953tXGgIaUTo47aE6Xw00GVVLv0N9yOcb0l9OO+
 AqXYKGg97ywfCIyN6U5DpIcDcjMtlnP7WpVcO5Bx4WX9IvZBnccyO8MoJW/jtX+TdJ56
 qhCmaQbj1M/KWDMvbbzMCVAsLB109Avl1jkzm2cHYpe4SMPLir5T41cpFPCWdyxsM9Be dA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pbpxtcaev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 16:20:13 -0700
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D8829C05B0;
        Fri, 17 Mar 2023 23:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679095212; bh=/ZhMSWRRzhjwWFfIcfiSnAX3OeDbtaMyr5x9TCHJftc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=B6EPkqLQiU5R4Np/jSbXuCVA5IkKNXAixhMH4+MdAJEAucOw7lmTCZjx4lCqdErBs
         dgqu8Ifn6yZNU1aPFnQ9PhhilQTUw0D35l1CBvHREbQY5PCRYUPh5W/pv24MViD5uJ
         uf7rjKTpYE7m5uXADBlE4gOBgqKMzaA0dcw4JANWKTobe7O/rfyoUzqsk3NxJ+gMyr
         dMRU0m4e9JTTdEeGrAESbTrK7FNN9cV3PvVwZol0kn+hwABwYVHD+yEg3bGPV2nDZB
         EZlRjppz9m7ewyAc6k+1x/Fq3TdmIpsT2EpHXcXshbATpg1RgQ0Xcz0BVjf1fLRdTu
         iuppz0mnH+V/A==
Received: from o365relay-in.synopsys.com (unknown [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 783ACA0062;
        Fri, 17 Mar 2023 23:20:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D5A0340119;
        Fri, 17 Mar 2023 23:20:09 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="hE9WVBN8";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsFhFT8L2mA4FtgFIQxcKdZATFQWB1OrvUCRTY8qOpxcEtY38ky39LzMI/BoCX0SmXTIr/cHk6G7iadtylHHM+9TQl84wSaviECVFnKHg1k9AGHUzJJ9pZ5A1/7Fottkg4pxt7AHb2TWDMErGn9gh1SfFeSoRhl9Z6gAKm4sxnNfSOdrAuC9hW/PVmhg8FG5a5PG96pBGDM72MwzIUomR02sA6oQwr5Ah73rr9Hd1eDXfwp6Qd1z1SwVoywPhZUe1XU+Li0HySf7fDQOXpOmTaaqQiZscacFwgGTY6LBA6IxBif08iOAi1Ly5Y8i6ZiyMcgggSxTgoPK2Exm0lfR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZhMSWRRzhjwWFfIcfiSnAX3OeDbtaMyr5x9TCHJftc=;
 b=D8COnYm/S4uAEqkTktYv40zXHj3AcS++u5II+ZRp88GOxJg1yOsbN+obcSy7nqDDYlC1Kuw2K9GVE1Z9kDOr4svFvdzInniIKBBBz4EIuWXIs8u+roU3fRYcWHMJBGxrt0cbRNHaEVciNVqJmHuRr3EzQum0wJPtz4LmoEFesdol+xcS52qX2KbSBelitUkl9Tz/4vUSG4vidjL7Lxi0/XCGDj+IykoONczXoR01NBT5ea17VsT5Uuf/MYnQ8TnZmMf/oH3M9kTkCeyJOy/I9l0rCBwkOiKu9b2lwWNft0nDVOLQh0kSWfP03XQd69u1pbBtWUZu7IXm8sEBeokBWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZhMSWRRzhjwWFfIcfiSnAX3OeDbtaMyr5x9TCHJftc=;
 b=hE9WVBN8Sn7lw6LH92LzA+wKIDwByywgCOhqMv+ffuEU7elOHyk9QhMI57LABkYzNaOrOSzvbCimJqcOzovYPIfMAlrDSf+cOkLh6HH19p4mDGqNMSbOB7r6SXx2xEJgBMIIQ0ChPRF10r4ekOMQereSsLfQIa/TmIM6opC1ufM=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 23:20:07 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 23:20:07 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v12 6/6] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Thread-Topic: [PATCH v12 6/6] usb: gadget: f_ecm: Add suspend/resume and
 remote wakeup support
Thread-Index: AQHZWGBkIcbTRueiF0WmOHHs1egwbK7+GWGAgAEqaoCAADpLgIAAHyEA
Date:   Fri, 17 Mar 2023 23:20:06 +0000
Message-ID: <20230317231956.w3kr3zcy44odxdko@synopsys.com>
References: <1679009888-8239-1-git-send-email-quic_eserrao@quicinc.com>
 <1679009888-8239-7-git-send-email-quic_eserrao@quicinc.com>
 <20230317001149.nlvcj2y3fuvq32qt@synopsys.com>
 <0bf5bddd-515b-76b6-f22f-9da10a140d83@quicinc.com>
 <20230317212831.bcapq26jnuk2vkws@synopsys.com>
In-Reply-To: <20230317212831.bcapq26jnuk2vkws@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MW5PR12MB5684:EE_
x-ms-office365-filtering-correlation-id: 38af23b3-20a3-48f5-35bb-08db273e2548
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jIat1SOyNVkWsi8E8DGiIXhRHlCw3VMkDK/YSeyNKOJpKUWNB2II/Nj0eMJZQZYgSFOFT/JoJKCCA97CkwUDJrQzFxmv9xfdQfbT9hixAhPuj0MlXNL9sfJTm/Crd3K/dtRafIq1teuk9CfJ07p/DHbBsZmnGRed/IcVyiL7DynQajGQhdO71tzrmjLyGd4fcMwofVJTloeBMQCIo8I6DvLaI1Boca6/8Lz2IJlVt1BgnJtevYs287PzJn+X8bupFwrQAkj0GBLh5Zaz6jIAKymUgguVtN5kwOimgGO8gEeUTonLX15+C5fOoYk700bT7aI7MEAfIpVAp5meAhNOPaDnFvPKJAi2C/bFxG5bit52bSLfAfCWyGyXm27tehZf8nfwBN96KHwNME6V3brDoEoflLgcNq+4vppq1ltRldLqG7hVLQeu7ZJE2K0bVUFPzlLYYOzcs1m9auDIl7saMcO9QtALJOV+Ig5VzCaekQMSytjx5D8nb6pTTqBBH6KBYmopbn7NHjmEm1syqtBXuO0UwfNoIfN1hPmLkSepCStxYhG7s4yZSmiOzdfU/YcbL47X++8tORoc4pXMw4LCPxkUWGI3jXvWcQJXDxQYySRsFwFcHFmY5FFSwlb6+h9GNbt8tp/qxzohjIMtk3OdRMK4t25LMy8WdhmC0gymf4lXmrpQCtiC3arahT5dYnI4ngBxLuDp4e2V9AsvUrezkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199018)(86362001)(38100700002)(36756003)(38070700005)(122000001)(478600001)(8936002)(2906002)(15650500001)(41300700001)(5660300002)(1076003)(6506007)(4326008)(6512007)(26005)(2616005)(53546011)(54906003)(316002)(186003)(83380400001)(6486002)(64756008)(66946007)(71200400001)(8676002)(66446008)(76116006)(66476007)(6916009)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXlWZ3N4QjluWi8vSjZkb0w3aUNRYzFHcjRVSDduOHBOazg0ZS95bVViaU1L?=
 =?utf-8?B?WTZFeHZZekl1bnBObUxTNFE1MVk0U1dDbVRwd3hQY2w1ZUpRRWdTbklRcTVX?=
 =?utf-8?B?akhUbTQ1VGRSaVNLYm5OalhiRm84NDlrSkQ2TEdCZDBwNTR5YUtjaTVkQzNt?=
 =?utf-8?B?SjNhSWYvK09ITHdvMVN2WGZXbTJpemc1alhCYldJTmpVdDA3aXMvUHZ5WjNB?=
 =?utf-8?B?VHBTT1JhbUpRMGpHR0ZzNVB0WHAyV0drc2R4SnNTRDhLVXZveEZDUkZxSEVz?=
 =?utf-8?B?MUE1ajdFR1IvTTZSMDFRenRhYVZoSHpYSis4NGsrN1J1UkJvUEFCUFNDcHlu?=
 =?utf-8?B?OStNcHpQZDBzMHJBVVI5TXlzMXI4R3hlWitwNTUrSDB5dS95cTJiZ1pLZ2tk?=
 =?utf-8?B?SG0rQ0hhNFBUUVI4d2JvWGxvdTY4Z3RYTFE1aEdsc0N6S0hOeE42bzJsTGkv?=
 =?utf-8?B?TFltNjRwWkpzZEhKd0daWXB3cEhoQ2tZekVOYTdYS2V6VHAvY3hvOW1yVE1S?=
 =?utf-8?B?a1VnemsvNnJqVXRhZCtBUXMzMDdyaVp1OWtLcklaeTdUeVVKYXdhanpOOXEx?=
 =?utf-8?B?Y0pYNFdEUU1wNkxwU05CaGpEWFhpRDF2T1JINVdVMm9iYkNDNlFTS1BJbzd1?=
 =?utf-8?B?WWxUcmd0TUhwNkkxZ0RiUVJjUnFQbDhRT1VucEJMaWdNRHR2YVJRMXRlcE9K?=
 =?utf-8?B?NC9UdnVOSHdidStPRk1mL3hiSTh4bUVvTlcxYlBjM01Xb0xqMWFsK3pFU0NI?=
 =?utf-8?B?cGViK1cyV0huQW1MaGlLNWkxaUZyNDV1YXVBNHVxdTFWRzRYN1A3UXdpV1Nk?=
 =?utf-8?B?M01PYjdiNDZVczVOVC8zY0FaV25tdmhlRHBqRzg3ZHMwNC8vWm05TmJVdjU0?=
 =?utf-8?B?c25Rb0dKcGR6UjIzNmptUFBEdGRmK3pVZmJFTFg5OWh5WFFldG5EYzJlNEpV?=
 =?utf-8?B?dS9ZcTE0cldlVGQydkxvUDB6TmEyWEhGQTFGN294dWFkb29Ib0NPS3NuaG9v?=
 =?utf-8?B?cU95VXIybU9QQnd4NUc3Z0JpVWZVLzZBOXptUlVyTVhydllMKzF1ZXlvdE52?=
 =?utf-8?B?NHRRSGo5aW5xcnM5anFod1I1ckZmM1J0NkExd0hoTWh1KzFocnNMQkhWbmVX?=
 =?utf-8?B?andxMnp1RGlZN1R6N29jM1dER3JXdTB0RWhITlZiNUN5cjZQSkdhd3JVb2Ny?=
 =?utf-8?B?am9XOG1uUTZHK1llaTB3N2pxb2hET3ExK0RBSkIvb3JyUmxTclZqNHQ2RHlR?=
 =?utf-8?B?Sk5VdkFqL2RaTlJIV0U0MzlSb0hjOWROQVNWUkNiS1IzMmd1UXNRM2pIVkZF?=
 =?utf-8?B?b2NBQmxoUm9KQmhLeU9HREhCL1NmOWdHK1cwOXpFVWd5d1kwdzB0OTJ3SmhU?=
 =?utf-8?B?MkJQWjE4RXR0cG5hV1A1NzUrMkt3QXJYVU9rb1UyL3NrMG83NTU2NFBNb0Rl?=
 =?utf-8?B?ZlQ4Z0NjN2lmaUx0Z2FsQ3YvcVZtcXpkbXRteWEzRU1JRVRCUjdLYjFTVGtF?=
 =?utf-8?B?TGRxUEFRZk83anB4cVM5dy9CUXM2aTRGNzk5SEM0Qlhxb3IvdThsS012NktY?=
 =?utf-8?B?dys3YVUvT3ZnSDlpK0dIZElEcHJCQ2piOEFVT2MxRFFkZGd3a3Q0MWFMM2py?=
 =?utf-8?B?c3FLYmlGbjNmd052L2x3UXpacXVJTzh6Tjc0a3ZWYmVEbTM0OUNzNFFHNkN2?=
 =?utf-8?B?VkR4QVRMZ0tLcTRZZEdRaDltZEZMRFZ4S2pvc0JmczRoUmZ2TnNYSXI5MTlS?=
 =?utf-8?B?VXNmRUkzS21aeHFxL2EzMVFHUDdUZ0w0dGtkbTJldGgwMitEajd0Y3pWK0FJ?=
 =?utf-8?B?bUtEOGdFZFd2SFFtczhjYVQ1SUlkRFk5c3JGL0RpRzQ3NUFUd1RXVk91WFdR?=
 =?utf-8?B?d2hrRzhlbFc0ZUdLV0tjWldIVkttS0xPdWlaRmNkOGtLTnVvSTlnUUM1YVRt?=
 =?utf-8?B?Q1NCQzdNdUxnL2plV1hoODY2KytRUnNCV2QzdWhSTTdNZUNKb2k4V1VHVUly?=
 =?utf-8?B?NnZjdm5JTkpFaysyZDR0aEluZllNV2VxY2krQ0ZNaVRraVRxa0RWVUR4ZXNY?=
 =?utf-8?B?b0c5QzhsVFlYUmJ1RFY2cWk2U3BvNFYrTWtoaUdBclUreit5NUJBdmo3MENM?=
 =?utf-8?Q?jILrZcEAGfb0DyiImQaJ7/mU4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15F6EE7F990BBC448D9B89A5DEF08EAF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BURIbWdWn96W1mqPMtoKBXz5QF9ToSOzZlAlW5BLGKh+waXh1KQBJOCQ6PPDHKJtd8y0El5mLdOeCBtIeA2gVEcCp1nDRCmowtArNfjhUBce/D12dPGvVsAcOdeLD1xpL/0KtzlRvO9IO7q3ugxKjxQlcsgJRYPx6P6Neh0n7+nsQgBOWZUV6iDb2fi1DudKOBtl7Y2v66QD1wwQhS4IFjR0ZTcGAhwwS6Ub6ZzQfk8g/LdfpOm6A1KZBD2TdY/oN7U9gzWyg/3w86+ltddf6XNwF0BmhlobU8W1DNJoaK7osRayyUIkW0E5DUrjg/dSv6o+VqK/mB/jLwehphSgzmY5NKrE/TTsKDfWOoHsyxVMoA8bQFSV4VamrQXUvgv88OyfqhgXXgX7Pwhpj4DLwsC5WozVoo5amqsqiPYV6yJTMjkSqCpetPPjUrF1GlBVHRsu5zNJZqskb4Ie+aA9k4dfJv9W6zyc94tRVXuNtVFslXOus9DrTzoCLz+GekU+TEtDlwj8uXvuudq6offaMPiRJixL+FKvC9cqS3XKZu1oJ7P+VAV3rzlP506sMzrQDTEaRJD/rSsOVX4xIL+eC6te8YjqnLxTj3tYEnOrD/VRI/gx/U0sEUDnWBbrBWD1Ro5ObM/4UH+yzmo95k2XOiwZeXXMV1N1xutzieXwW6tr9my3XaK+UiFFR99jM4gcQ4TecChBpVYOpcyTBUJhyhjmy0MGg1FY9VK5ugJx+JRD+Q7EBuaMujtpAl2EpxFUPlamISTYwEdt9p6H5OGBplGqCt0J8S6jccJFqrBmYe9VU/n20+TPMkEOWvNXC70TaO5rPZBrClwmnjtTIV1ciNV0U4iIbZEwzvs2DScI6bYKvcehwpbF8wNHBYLFXOle4243HbytBQP6+MtmA+T8/w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38af23b3-20a3-48f5-35bb-08db273e2548
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 23:20:06.9533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6PTDICOukAfqRb7dsR+SeivTbSR4Y6ZAFcsFRVVWJUPmlmXz0Xfo9UdV3O84YJ4iHJkjVRKHr3gFnxg00+4Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
X-Proofpoint-GUID: RGiL-nUnmqqxkPk9ww75iQ3WK6yta1IK
X-Proofpoint-ORIG-GUID: RGiL-nUnmqqxkPk9ww75iQ3WK6yta1IK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_17,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303170167
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXIgMTcsIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gRnJpLCBNYXIg
MTcsIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gPiANCj4gPiANCj4gPiBPbiAzLzE2LzIw
MjMgNToxMSBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBNYXIgMTYsIDIw
MjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+ID4gPiA+IFdoZW4gaG9zdCBzZW5kcyBhIHN1
c3BlbmQgbm90aWZpY2F0aW9uIHRvIHRoZSBkZXZpY2UsIGhhbmRsZQ0KPiA+ID4gPiB0aGUgc3Vz
cGVuZCBjYWxsYmFja3MgaW4gdGhlIGZ1bmN0aW9uIGRyaXZlci4gRW5oYW5jZWQgc3VwZXINCj4g
PiA+ID4gc3BlZWQgZGV2aWNlcyBjYW4gc3VwcG9ydCBmdW5jdGlvbiBzdXNwZW5kIGZlYXR1cmUg
dG8gcHV0IHRoZQ0KPiA+ID4gPiBmdW5jdGlvbiBpbiBzdXNwZW5kIHN0YXRlLiBIYW5kbGUgZnVu
Y3Rpb24gc3VzcGVuZCBjYWxsYmFjay4NCj4gPiA+ID4gDQo+ID4gPiA+IERlcGVuZGluZyBvbiB0
aGUgcmVtb3RlIHdha2V1cCBjYXBhYmlsaXR5IHRoZSBkZXZpY2UgY2FuIGVpdGhlcg0KPiA+ID4g
PiB0cmlnZ2VyIGEgcmVtb3RlIHdha2V1cCBvciB3YWl0IGZvciB0aGUgaG9zdCBpbml0aWF0ZWQg
cmVzdW1lIHRvDQo+ID4gPiA+IHN0YXJ0IGRhdGEgdHJhbnNmZXIgYWdhaW4uDQo+ID4gPiA+IA0K
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFbHNvbiBSb3kgU2VycmFvIDxxdWljX2VzZXJyYW9AcXVp
Y2luYy5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5j
dGlvbi9mX2VjbS5jICAgfCA3MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ID4gPiAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2V0aGVyLmMgfCA2MyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICAgZHJpdmVycy91c2IvZ2FkZ2V0
L2Z1bmN0aW9uL3VfZXRoZXIuaCB8ICA0ICsrDQo+ID4gPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAx
MzggaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2dhZGdldC9mdW5jdGlvbi9mX2VjbS5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9u
L2ZfZWNtLmMNCj4gPiA+ID4gaW5kZXggYTdhYjMwZS4uYzQzY2Q1NTcgMTAwNjQ0DQo+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2VjbS5jDQo+ID4gPiA+ICsrKyBi
L2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2VjbS5jDQo+ID4gPiA+IEBAIC02MzMsNiAr
NjMzLDggQEAgc3RhdGljIHZvaWQgZWNtX2Rpc2FibGUoc3RydWN0IHVzYl9mdW5jdGlvbiAqZikN
Cj4gPiA+ID4gICAJdXNiX2VwX2Rpc2FibGUoZWNtLT5ub3RpZnkpOw0KPiA+ID4gPiAgIAllY20t
Pm5vdGlmeS0+ZGVzYyA9IE5VTEw7DQo+ID4gPiA+ICsJZi0+ZnVuY19zdXNwZW5kZWQgPSBmYWxz
ZTsNCj4gPiA+ID4gKwlmLT5mdW5jX3dha2V1cF9hcm1lZCA9IGZhbHNlOw0KPiA+ID4gPiAgIH0N
Cj4gPiA+ID4gICAvKi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0qLw0KPiA+ID4gPiBAQCAtODg1LDYgKzg4Nyw3
MSBAQCBzdGF0aWMgc3RydWN0IHVzYl9mdW5jdGlvbl9pbnN0YW5jZSAqZWNtX2FsbG9jX2luc3Qo
dm9pZCkNCj4gPiA+ID4gICAJcmV0dXJuICZvcHRzLT5mdW5jX2luc3Q7DQo+ID4gPiA+ICAgfQ0K
PiA+ID4gPiArc3RhdGljIHZvaWQgZWNtX3N1c3BlbmQoc3RydWN0IHVzYl9mdW5jdGlvbiAqZikN
Cj4gPiA+ID4gK3sNCj4gPiA+ID4gKwlzdHJ1Y3QgZl9lY20gKmVjbSA9IGZ1bmNfdG9fZWNtKGYp
Ow0KPiA+ID4gPiArCXN0cnVjdCB1c2JfY29tcG9zaXRlX2RldiAqY2RldiA9IGVjbS0+cG9ydC5m
dW5jLmNvbmZpZy0+Y2RldjsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWlmIChmLT5mdW5jX3N1c3Bl
bmRlZCkgew0KPiA+ID4gPiArCQlEQkcoY2RldiwgIkZ1bmN0aW9uIGFscmVhZHkgc3VzcGVuZGVk
XG4iKTsNCj4gPiA+ID4gKwkJcmV0dXJuOw0KPiA+ID4gPiArCX0NCj4gPiA+ID4gKw0KPiA+ID4g
PiArCURCRyhjZGV2LCAiRUNNIFN1c3BlbmRcbiIpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJZ2V0
aGVyX3N1c3BlbmQoJmVjbS0+cG9ydCk7DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4g
K3N0YXRpYyB2b2lkIGVjbV9yZXN1bWUoc3RydWN0IHVzYl9mdW5jdGlvbiAqZikNCj4gPiA+ID4g
K3sNCj4gPiA+ID4gKwlzdHJ1Y3QgZl9lY20gKmVjbSA9IGZ1bmNfdG9fZWNtKGYpOw0KPiA+ID4g
PiArCXN0cnVjdCB1c2JfY29tcG9zaXRlX2RldiAqY2RldiA9IGVjbS0+cG9ydC5mdW5jLmNvbmZp
Zy0+Y2RldjsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCS8qDQo+ID4gPiA+ICsJICogSWYgdGhlIGZ1
bmN0aW9uIGlzIGluIFVTQjMgRnVuY3Rpb24gU3VzcGVuZCBzdGF0ZSwgcmVzdW1lIGlzDQo+ID4g
PiA+ICsJICogY2FuY2VsZWQuIEluIHRoaXMgY2FzZSByZXN1bWUgaXMgZG9uZSBieSBhIEZ1bmN0
aW9uIFJlc3VtZSByZXF1ZXN0Lg0KPiA+ID4gPiArCSAqLw0KPiA+ID4gPiArCWlmIChmLT5mdW5j
X3N1c3BlbmRlZCkNCj4gPiA+ID4gKwkJcmV0dXJuOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJREJH
KGNkZXYsICJFQ00gUmVzdW1lXG4iKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWdldGhlcl9yZXN1
bWUoJmVjbS0+cG9ydCk7DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBp
bnQgZWNtX2dldF9zdGF0dXMoc3RydWN0IHVzYl9mdW5jdGlvbiAqZikNCj4gPiA+ID4gK3sNCj4g
PiA+ID4gKwlzdHJ1Y3QgdXNiX2NvbmZpZ3VyYXRpb24gKmMgPSBmLT5jb25maWc7DQo+ID4gPiA+
ICsNCj4gPiA+ID4gKwkvKiBEMCBhbmQgRDEgYml0IHNldCB0byAwIGlmIGRldmljZSBpcyBub3Qg
d2FrZXVwIGNhcGFibGUgKi8NCj4gPiA+ID4gKwlpZiAoIShVU0JfQ09ORklHX0FUVF9XQUtFVVAg
JiBjLT5ibUF0dHJpYnV0ZXMpKQ0KPiA+ID4gPiArCQlyZXR1cm4gMDsNCj4gPiA+ID4gKw0KPiA+
ID4gPiArCXJldHVybiAoZi0+ZnVuY193YWtldXBfYXJtZWQgPyBVU0JfSU5UUkZfU1RBVF9GVU5D
X1JXIDogMCkgfA0KPiA+ID4gPiArCQlVU0JfSU5UUkZfU1RBVF9GVU5DX1JXX0NBUDsNCj4gPiA+
ID4gK30NCj4gPiA+IA0KPiA+ID4gV2h5IGRvIHdlIG5lZWQgdG8gaW1wbGVtZW50IGVjbV9nZXRf
c3RhdHVzIGlmIGl0J3MgYWxyZWFkeSBoYW5kbGVkIGluDQo+ID4gPiBjb21wb3NpdGUuYyBub3c/
DQo+ID4gPiANCj4gPiANCj4gPiBZZXMgdGhpcyBjYW4gYmUgcmVtb3ZlZCBub3cuIFdpbGwgbW9k
aWZ5IGFjY29yZGluZ2x5Lg0KPiA+ID4gPiArDQo+ID4gPiA+ICtzdGF0aWMgaW50IGVjbV9mdW5j
X3N1c3BlbmQoc3RydWN0IHVzYl9mdW5jdGlvbiAqZiwgdTggb3B0aW9ucykNCj4gPiA+ID4gK3sN
Cj4gPiA+ID4gKwlzdHJ1Y3QgdXNiX2NvbXBvc2l0ZV9kZXYgKmNkZXYgPSBmLT5jb25maWctPmNk
ZXY7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlEQkcoY2RldiwgImZ1bmMgc3VzcCAldSBjbWRcbiIs
IG9wdGlvbnMpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJaWYgKG9wdGlvbnMgJiAoVVNCX0lOVFJG
X0ZVTkNfU1VTUEVORF9MUCA+PiA4KSkgew0KPiA+ID4gDQo+ID4gPiBUaGlzIGZlYXR1cmUgc2Vs
ZWN0b3IgZG9lc24ndCBpbmRpY2F0ZSB3aGV0aGVyIGl0J3MgU2V0RmVhdHVyZSBvcg0KPiA+ID4g
Q2xlYXJGZWF0dXJlIHJlcXVlc3QuIGVjbV9mdW5jX3N1c3BlbmQgaXMgc3VwcG9zZWQgdG8gYmUg
Zm9yDQo+ID4gPiBTZXRGZWF0dXJlKHN1c3BlbmQpIG9ubHkuIFBlcmhhcHMgd2UgbWF5IGhhdmUg
dG8gZGVmaW5lIGZ1bmNfcmVzdW1lKCkNCj4gPiA+IGZvciBDbGVhckZlYXR1cmUoc3VzcGVuZCk/
DQo+ID4gPiANCj4gDQo+ID4gSG9zdCB1c2VzIHRoZSBzYW1lIGZlYXR1cmUgc2VsZWN0b3IgRlVO
Q1RJT05fU1VTUEVORCBmb3IgZnVuY3Rpb24gc3VzcGVuZA0KPiA+IGFuZCBmdW5jdGlvbiByZXN1
bWUgYW5kIGZ1bmNfc3VzcGVuZCgpIGNhbGxiYWNrIGNhbiBiZSB1c2VkIHRvDQo+ID4gaGFuZGxl
IGJvdGggdGhlIGNhc2VzID8gVGhlIGRpc3RpbmN0aW9uIGNvbWVzIHdoZXRoZXIgaXQgaXMgYQ0K
PiANCj4gSG93IGRvIHlvdSBwbGFuIHRvIGhhbmRsZSB0aGF0PyBQYXNzIHRoaXMgaW5mbyBpbiBz
b21lIHVudXNlZC9yZXNlcnZlZA0KPiBiaXQgb2YgdGhlICJvcHRpb25zIiBhcmd1bWVudD8gSW50
cm9kdWNlIGEgbmV3IHBhcmFtZXRlciB0byB0aGUNCj4gZnVuY19zdXNwZW5kKCk/DQo+IA0KPiBJ
ZiB0aGF0J3MgdGhlIGNhc2UsIHRoZW4geW91IG5lZWQgdG8gdXBkYXRlIHRoZSBkb2N1bWVudCBv
bg0KPiBmdW5jX3N1c3BlbmQoKSB0byBhbHNvIHN1cHBvcnQgQ2xlYXJGZWF0dXJlKHN1c3BlbmQp
LiBSaWdodCBub3cgaXQncw0KPiBkb2N1bWVudGVkIGZvciBTZXRGZWF0dXJlIG9ubHkuIEFsc28s
IG1ha2Ugc3VyZSB0aGF0IG90aGVyIGV4aXN0aW5nDQo+IGZ1bmN0aW9uIGRyaXZlcnMgd2lsbCBu
b3QgYnJlYWsgYmVjYXVzZSBvZiB0aGUgY2hhbmdlIG9mIHRoZQ0KPiBmdW5jX3N1c3BlbmQgYmVo
YXZpb3IuDQo+IA0KPiA+IFNldEZlYXR1cmUoRlVOQ1RJT05fU1VTUEVORCkgb3IgQ2xlYXJGZWF0
dXJlKEZVTkNUSU9OX1NVU1BFTkQpIHdoaWNoIGNhbiBiZQ0KPiA+IGVhc2lseSBkb25lIGluIHRo
ZSBmdW5jX3N1c3BlbmQgY2FsbGJhY2sgaXRzZWxmLiBXZSBjYW4gYWRkIGFub3RoZXIgY2FsbGJh
Y2sNCj4gPiBmdW5jX3Jlc3VtZSBzcGVjaWZpYyB0byBDbGVhckZlYXR1cmUoRlVOQ1RJT05fU1VT
UEVORCkgYnV0IHdvbnQgdGhhdCBiZQ0KPiA+IHJlZHVuZGFudCBhbmQgbW9yZSBjYWxsYmFjayBo
YW5kbGluZyBvbiBmdW5jdGlvbiBkcml2ZXIvY29tcG9zaXRlIHNpZGUgYXMNCj4gPiB3ZWxsPyBQ
bGVhc2UgbGV0IG1lIGtub3cgeW91ciBvcGluaW9uLg0KPiA+IA0KPiANCj4gV2UgYWN0dWFsbHkg
ZGlkbid0IHByb3Blcmx5IGRlZmluZSBmdW5jX3N1c3BlbmQgYW5kIGl0cyBjb3VudGVyIHBhcnQu
IEl0DQo+IHNlZW1zIGNsZWFuZXIgdG8gbWUgdG8gaW50cm9kdWNlIGZ1bmNfcmVzdW1lIGFzIGl0
IHNlZW1zIG1vcmUgaW50dWl0aXZlDQo+IGFuZCBlYXNpZXIgdG8gcmVhZC4gTGV0IG1lIGtub3cg
aG93IHlvdSBwbGFuIHRvIHVzZSBmdW5jX3N1c3BlbmQoKSBmb3INCj4gYm90aCBjYXNlcy4NCj4g
DQoNCkhvdyBhYm91dCB3ZSBoYW5kbGUgZnVuY3Rpb24gc3VzcGVuZCByZXN1bWUgaW4gY29tcG9z
aXRlIGFsc28/IEkgbWVhbg0Kc29tZXRoaW5nIGxpa2UgdGhpczoNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3Np
dGUuYw0KaW5kZXggMzZhZGQxODc5ZWQyLi43OWRjMDU1ZWI1ZjcgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9jb21w
b3NpdGUuYw0KQEAgLTE5NDgsOSArMTk0OCwxOCBAQCBjb21wb3NpdGVfc2V0dXAoc3RydWN0IHVz
Yl9nYWRnZXQgKmdhZGdldCwgY29uc3Qgc3RydWN0IHVzYl9jdHJscmVxdWVzdCAqY3RybCkNCiAJ
CWYgPSBjZGV2LT5jb25maWctPmludGVyZmFjZVtpbnRmXTsNCiAJCWlmICghZikNCiAJCQlicmVh
azsNCi0JCXN0YXR1cyA9IGYtPmdldF9zdGF0dXMgPyBmLT5nZXRfc3RhdHVzKGYpIDogMDsNCi0J
CWlmIChzdGF0dXMgPCAwKQ0KLQkJCWJyZWFrOw0KKw0KKwkJaWYgKGYtPmdldF9zdGF0dXMpIHsN
CisJCQlzdGF0dXMgPSBmLT5nZXRfc3RhdHVzKGYpOw0KKwkJCWlmIChzdGF0dXMgPCAwKQ0KKwkJ
CQlicmVhazsNCisJCX0gZWxzZSB7DQorCQkJaWYgKGYtPmNvbmZpZy0+Ym1BdHRyaWJ1dGVzICYg
VVNCX0NPTkZJR19BVFRfV0FLRVVQKSB7DQorCQkJCXN0YXR1cyB8PSBVU0JfSU5UUkZfU1RBVF9G
VU5DX1JXX0NBUDsNCisJCQkJaWYgKGYtPmZ1bmNfd2FrZXVwX2FybWVkKQ0KKwkJCQkJc3RhdHVz
IHw9IFVTQl9JTlRSRl9TVEFUX0ZVTkNfUlc7DQorCQkJfQ0KKwkJfQ0KIAkJcHV0X3VuYWxpZ25l
ZF9sZTE2KHN0YXR1cyAmIDB4MDAwMGZmZmYsIHJlcS0+YnVmKTsNCiAJCWJyZWFrOw0KIAkvKg0K
QEAgLTE5NzEsOSArMTk4MCwyOCBAQCBjb21wb3NpdGVfc2V0dXAoc3RydWN0IHVzYl9nYWRnZXQg
KmdhZGdldCwgY29uc3Qgc3RydWN0IHVzYl9jdHJscmVxdWVzdCAqY3RybCkNCiAJCQlmID0gY2Rl
di0+Y29uZmlnLT5pbnRlcmZhY2VbaW50Zl07DQogCQkJaWYgKCFmKQ0KIAkJCQlicmVhazsNCisJ
CQlpZiAod19pbmRleCAmIFVTQl9JTlRSRl9GVU5DX1NVU1BFTkRfUlcpIHsNCisJCQkJaWYgKCEo
Zi0+Y29uZmlnLT5ibUF0dHJpYnV0ZXMgJiBVU0JfQ09ORklHX0FUVF9XQUtFVVApKQ0KKwkJCQkJ
YnJlYWs7DQorDQorCQkJCWYtPmZ1bmNfd2FrZXVwX2FybWVkID0gKGN0cmwtPmJSZXF1ZXN0ID09
IFVTQl9SRVFfU0VUX0ZFQVRVUkUpOw0KKwkJCX0NCisNCiAJCQl2YWx1ZSA9IDA7DQotCQkJaWYg
KGYtPmZ1bmNfc3VzcGVuZCkNCisJCQlpZiAoZi0+ZnVuY19zdXNwZW5kKSB7DQogCQkJCXZhbHVl
ID0gZi0+ZnVuY19zdXNwZW5kKGYsIHdfaW5kZXggPj4gOCk7DQorCQkJfSBlbHNlIGlmICh3X2lu
ZGV4ICYgVVNCX0lOVFJGX0ZVTkNfU1VTUEVORF9MUCkgew0KKwkJCQlpZiAoZi0+c3VzcGVuZCAm
JiAmJiAhZi0+ZnVuY19zdXNwZW5kZWQgJiYNCisJCQkJICAgIGN0cmwtPmJSZXF1ZXN0ID09IFVT
Ql9SRVFfU0VUX0ZFQVRVUkUpKSB7DQorCQkJCQlmLT5zdXNwZW5kKGYpOw0KKwkJCQkJZi0+ZnVu
Y19zdXNwZW5kZWQgPSB0cnVlOw0KKwkJCQl9IGVsc2UgaWYgKGYtPnJlc3VtZSAmJiBmLT5mdW5j
X3N1c3BlbmRlZCAmJg0KKwkJCQkJICAgY3RybC0+YlJlcXVlc3QgPT0gVVNCX1JFUV9DTEVBUl9G
RUFUVVJFX0ZFQVRVUkUpKSB7DQorCQkJCQlmLT5yZXN1bWUoZik7DQorCQkJCQlmLT5mdW5jX3N1
c3BlbmRlZCA9IGZhbHNlOw0KKwkJCQl9DQorCQkJfQ0KKw0KIAkJCWlmICh2YWx1ZSA8IDApIHsN
CiAJCQkJRVJST1IoY2RldiwNCiAJCQkJICAgICAgImZ1bmNfc3VzcGVuZCgpIHJldHVybmVkIGVy
cm9yICVkXG4iLA0KDQoNCkFsc28sIGRvIHdlIG5lZWQgdGhlIGYtPmZ1bmNfc3VzcGVuZGVkIGZs
YWc/IHdlJ2QgbmVlZCB0aGUgcmVtb3RlIHdha2V1cA0KZmxhZyBmb3IgdGhlIHN0YXR1cywgYnV0
IHdoZW4gZG8gd2UgbmVlZCBmLT5mdW5jX3N1c3BlbmRlZD8gSXQgc2VlbXMNCmxpa2UgaXQgY2Fu
IGJlIGhhbmRsZWQgd2l0aGluIHRoZSBmdW5jdGlvbiBkcml2ZXIncyBzY29wZS4NCg0KVGhhbmtz
LA0KVGhpbmg=
