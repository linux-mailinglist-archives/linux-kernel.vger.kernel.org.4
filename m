Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08AE6B831E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCMUw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCMUwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:52:38 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7041D907;
        Mon, 13 Mar 2023 13:52:36 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DK8XNv013334;
        Mon, 13 Mar 2023 13:29:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=2gnKLAJqfA9oD3EjcL8YzGQBRl8XVIug76AvCooRk6k=;
 b=PaOYIR4Lq35d9T6ZDGVxrNOAC081DMk1ZLItOijn5yrlk7qQejZu9FH5TSoAyl6FeT7G
 OVbo7lYUgu9qgEbpVXP6V11634N0oLSi/yVT4D2wCwuwbr2OKTeu2MPE551B0dQglanT
 zQv4LOn179Qs5+44ZWZccmWt4/Wqcr4Oj1xJQvMwqR/hkqtv6DN8rgEjGWou2NEh2Sop
 S4jPj0cpjnPH6T7qmxNfs7sAFLdIs+vvZ2SK1JnRs2v5Pkk2noLiGfpE9YJ7J2EqxP7u
 nQ1vjpbIkJoVeSFkfBK3Ys+pMWE43alBT2awht9XPJgSWTmLTcX13YvZyh/fjnGVVQ99 9Q== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3p9ansett2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 13:29:16 -0700
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7C332C04BF;
        Mon, 13 Mar 2023 20:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1678739355; bh=2gnKLAJqfA9oD3EjcL8YzGQBRl8XVIug76AvCooRk6k=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=c78+7qqjxvvYdMfT2owaHyjJUuhgE/Caa5Uwh5NSlc15aQB9QodDLgOiW/LE+BsZS
         PhU3RtyJNwPNAE6g5TDVB3JcAO/dv78hkjf/0vxTkth+l7b+t5bqd3cjmn/FJWsXr2
         uTCDG3K1uSVeAcpqQHdvzcTNyVJLhLsILhuat/1lGekUELRnWWBgysbuJkg1MAprVm
         g2Yn0ONkUsV2O96zvm4Lo5BsB7FWFtTYP3aN+75kYaATCu8WbtkAtO4itOic08hwLq
         jqKuwqIJh+aPMOiNoGkKkVoGSoa44etCC6HnpBgm+YhUjJXJ99+6euqlIPQ9HPPzjk
         /i2/ZE40kOMOQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6A31CA0060;
        Mon, 13 Mar 2023 20:29:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8A7574006A;
        Mon, 13 Mar 2023 20:29:13 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="R2snetq7";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD1eLbzCpOUOA5Mbv2OfNjtlMhY6l1k2+ImeFYIS1PopILEAibDH5nPH4FDheGbRaBPoiR2guavdP2W6MXTpdyerfn7EW4yfzBPSi/Iu4494TIZVPdPFsr/QIUinJnlePxGtGJFHuKz79UYsfs1eQo35ob/8VxOmITRW7tJyRLdBcUY0Vs+M+WBBB8FhzXMu73bsZePuumDe5J0VMxoasWI6bOCBcUr9QtKi07M23yssEGMHCPkIl1B6ZJjRh1m/5LWbpTxWaBrnI+tUXA15YRT5j2VEGnmtnYn49sTato8bdglNGAx7S9pyKcfPpRxZAX+Ajd+MIl/lPUMgoNZhBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gnKLAJqfA9oD3EjcL8YzGQBRl8XVIug76AvCooRk6k=;
 b=M7VHfvxzCk1TgMrKxh1D/hETZdXX4LDXRCy4hUNBKwB+sC1xhTjnAkHBXKWMSQ5w3mhr4Jimk5IY052vT5p7fqZfrFBe+mVoFaYGLHtmv9pQOBZkJYwAXM/bDA248hDw8ooLYryGyRYZnZaDQHSGZJ0lANlkx+N/93ab66o8Sz26yiPRD36HiDVPh+AzLGgH9I9hXyVJzPe+C1MbfUlamkD5Qgq6uH89Ys5XgG0Ko4g2WhTjtlYigosDW3ZJHOu3Op34v/2ibIlKj2iBQcq0NwL7nyj3SX3CYZtwaKvdUDz6uG4dXsWGkTwweerVi/8Gt/ws3hw9sbaJvUmUsafXWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gnKLAJqfA9oD3EjcL8YzGQBRl8XVIug76AvCooRk6k=;
 b=R2snetq78DvEioSNOEeshHXiHdCAoiQ2YeXa82gsjpkJKxaZ40RvawzafohBGn7bpbybY+D36lsYX3i+xGXVfv1lckyZHUDwSGbI4l+w0A2FsWE0bsuHAsG6I0BKR4PSwRGiEBMNprpC+IFrpmtqX8//iKUTGFH0WrfvKOPpv14=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ0PR12MB5470.namprd12.prod.outlook.com (2603:10b6:a03:3bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 20:29:10 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 20:29:10 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v8 2/5] usb: dwc3: Add remote wakeup handling
Thread-Topic: [PATCH v8 2/5] usb: dwc3: Add remote wakeup handling
Thread-Index: AQHZVdklvI91j6S85k6FpA4BQZoKgK75KTcA
Date:   Mon, 13 Mar 2023 20:29:10 +0000
Message-ID: <20230313202906.sipnf7xruvkggrev@synopsys.com>
References: <1678731892-20503-1-git-send-email-quic_eserrao@quicinc.com>
 <1678731892-20503-3-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1678731892-20503-3-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ0PR12MB5470:EE_
x-ms-office365-filtering-correlation-id: 5cb93e48-c1f5-422f-6edb-08db24019a3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jZnEgZ90yfZ7LSf28BjNb9Eym5vJR1lRyy7kWUqoOyx01XtRgknmhNZc/KoahScQfFHEMTseQD5JSQHSBsuuXvU82vSX/1eeygg8PrScc+SHaHLjb70hIL6IXKOSjv8CJia+9frFYpM53NEfKei3d2G03Y/MPtbziDbyPS72uRM5NBCYjnlaGNgkXNgU9htHKo+O/zulArb6bPVaUcf+W5+y70kYf//J0L3RQUitUn4xjXgfIfE/WXvcjkt0OEx5n7vyNWDsjA1QkFMEHBzmOVpomM3pRtFOMrLrjZUHQVJhU0UJYoNAi0cLy91FnYKbXfIJJ63I2FnAOX6hSTwDQ89cWBTEjE3cQmui/owiV8J4GXrZCj89EZCxYmEhw3aQhizK/gg00NwTsKW1PxYb9i8WwQr2Rm5USSdPy12M0aMToDKAEQKktsA6i2DUL5heh4MIXiwl6uZAbeqLkA+EAROv3fjpx7yHGelN8WBMj2x6or0XQm6X31c+GZ+IWAGCgOVF2b7Zj+r3pB3ys7CAVVLljFQV7S2rYeyxJCryCYYRPyEDjJa2s4+gXxGH0UTWeHkOrvVGkwYhYv2f+CI0sP9JiI+p8/JeVUgMN1Ocfy7hfG8IT0xlCgrN+T2T2+EvfOTgwrRR6s1Pc7TzpiMd6Z1O5w1PRCKf5P/5C60fxzwhjuu7ySI/GcMn8B9zgfnAD22+5V9VO/Yq1PXhl83MbKrSOZ7lBHUx6bdo9C2goCs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199018)(2616005)(1076003)(186003)(26005)(6506007)(6512007)(8936002)(83380400001)(38100700002)(6486002)(38070700005)(5660300002)(66476007)(4326008)(64756008)(66446008)(66556008)(2906002)(71200400001)(8676002)(76116006)(41300700001)(122000001)(36756003)(316002)(478600001)(66946007)(86362001)(54906003)(6916009)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2x0RTIvdHMzZkhMbElCaUFSMzJ6aGY5SGllNmRmTVFPNWdlK3gxSGVhZ0Fy?=
 =?utf-8?B?VElxaXU5S20wbGQ5cnRGeExNelV1QlljenAycG5MUmplNEV0NjNzNEtmdFQ3?=
 =?utf-8?B?SnNoTG9oaW42cFFMU0s0a1RlTytGdWQrWjFmZFdSTk1qeTA0MVl4M1dFQTVs?=
 =?utf-8?B?QktrM2hISmZHbzJiNTlsN2RRVU15cFhkQmdHQXNad1lWdXBvSEJ6Uml1SEhk?=
 =?utf-8?B?Yktkc3YwL1QvY3UyZktvLzdtWTBUOVN2S3ZVUzM2MFN0UVRwcGc0b3ZGM2l3?=
 =?utf-8?B?WTdhajZaUlM4bDc1UmZvRzQrQW9JLzRUaDJZWlp5b05yN29QM2h2Q3Fwdklo?=
 =?utf-8?B?THRKaG0rMGoxaFM3a2IyMnduVjRqTHlqZkNMZUNLL0NoSWJTTmlpb3ZJQ1dH?=
 =?utf-8?B?d05LV1MxMEV6OFAzZGhuYTNtZ09DaFViWE91azZidGVWUWZJbWQzYU5UQmxH?=
 =?utf-8?B?YVRFTnFBeWh5TWE3aXJ5a2NWMWNhMUZRM1REUW9RcElvU0d1NWI3b2NiNnhN?=
 =?utf-8?B?NTFPWUJnNUViTjNmdFgrWkFOZjJ6YXNibG9QeFo0empGeXd6dkJQUW1JcnAv?=
 =?utf-8?B?enhUcVlvYWtwRlFtY1oyMVd2R1RTRjVEYnNIZ2tlWWFhZEYxTjhldndqaHRh?=
 =?utf-8?B?dGI4THlNRSs2UUtucXl5RlZ6Tm9IZzJ5OTh4QTJZK2d0RFJOYXdnckV2K1l4?=
 =?utf-8?B?bzUyUk96NmtyTm5ZQnE5TFhkYjREZlBLd2o3REZhc2VUUUlxNHRRbnFKUGNs?=
 =?utf-8?B?YXE0QS9IZTJObCtXVVNVcDk0WHNuTkw0UmVWcWFVWC9sTnFZSk55c3dwV01v?=
 =?utf-8?B?THlHUld6dXNVTGN5QitpeHBuTXdPaEVxeFU0elRML3ZQMWJ0OU1EY2VHWmtv?=
 =?utf-8?B?WGhqeUxaZTYvQjZoWEszWVkrZE5JWTFDVUxxbXk3OU1jNklsTmRGWCt4K2Rp?=
 =?utf-8?B?OThRSGRFM0ZnSHpaUWd2NDV3WTkyVDVXRGU5a0ZMYU1MeUx3aXV3NkVUUnRU?=
 =?utf-8?B?c3phVStqSGVZM3MyL3ozeUVLc3BsaUVUOUdQemVWNFJsNlhXeFVlRDdzN242?=
 =?utf-8?B?Y0Z5K2dvdGZaRGVScTd0V0E4YW56TzZBNHU3VjJFZXNZMk1HWFhSZ2VUY1ln?=
 =?utf-8?B?dkJtQkE4SUNqQVArTFNjRjI5b0RackRqa1A3dDI4YTgzRlYrRWZRY1FmRTZ1?=
 =?utf-8?B?Z3ZmUGM3VnR4Y0d5K0lDbkk4anFHdC83aXVFZzYveTMvTnNpUGRwN1p5WDlh?=
 =?utf-8?B?SnZlOHJ4TGhkSGo5NGh3TFhUeSttS09sYXhrT1paSC9iSUVkbzhwN1Z0bVNv?=
 =?utf-8?B?cmlRYXNSUDhDbFRiK09wNjd1dy9lNmp3M2gwaXQzenEydVAvU3BzbmVUTU1L?=
 =?utf-8?B?N2dWYXdBOVBub0N5aEtHUi83a2tHd3R3LzFMWHRMYXczUFNRSWdwWWNGWUNr?=
 =?utf-8?B?bnpvNEs0NjFLWW1MNmN6ZDlaa2UrUUd1clErcEVibUZTQ0QyWWVZdU5abDJp?=
 =?utf-8?B?WFpwYVI1STNzRXo3c1l1MnF4MWpPblUzQUNlV2Z5ajdrZUxUVHQ2VytSMXU5?=
 =?utf-8?B?R3ZveDRTZlNYZzlrZUVmdElnN3NaVGhtQ1FhZm1SQUc3bnBPQlZRSmE3SWFk?=
 =?utf-8?B?L2FOOXM3Y2VDSVc2TlZYQTJvdTFsTmlDaDFvYVZpRXJkWm1vSHMzYlVwa21z?=
 =?utf-8?B?eDRFMzJNNzBqbHIrOFVzUXVaUjI1ZExyVTQxTDBWWHdKckp2NUtscVdwbnRO?=
 =?utf-8?B?OFY0eDhnbGxBVVlyVnEydTJxaXI1cFhUeHNCVTJCdUg5UUhHK2lIS1BCdXVp?=
 =?utf-8?B?UXVJbUpxTk41K05UMktneThERjRac0xiQXcwaEpQRDVsV0U1ZFJ0dVRxSGVM?=
 =?utf-8?B?ZjVhNzVlOG1vR1FxWUdRZ05FT0srbTRHMkRTZ3p6VVBhU0VIVG91V3lsaGNC?=
 =?utf-8?B?NFp2M29VTmRDcHRQd1FWV1Zlc1JZUEkvSU9lVEZpWnZsdWM4WEV3NUNYRE5B?=
 =?utf-8?B?UVl4UWw2TmxiYUxQNVJxWUlSVkNZMTA2SnNQbzRTN0F6aDdWL1Z4N1hSbTA4?=
 =?utf-8?B?WTlBL05oTjJpTXN2cEpnUzN2c0ZoM0k0bEtTZ3ZsbU5oNllNL2RVWGNCYStG?=
 =?utf-8?Q?eD2yzSl4noNeUHLXuYul/xPEM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBCD82B5CDFA264986B033AB1598659C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X5NYZVjH0PJWXnF085kpE4UHnEBNRz35LQL2LMSBo21zDoUwH8ykeA0oQVAe/qBdYe9c9jHmGhBvttquJ1yFWjSlxmjsIae9SHEp+fL8wSQfU1BL6p/4RARLiqUu//tidR6E7+PGTnBL3ePGKqe1lBQDozdEQvpms2XTI3VRdxTwtnhYd0dRrQ5VuAZH7Rb8t7SM+7m69YOcVqCYJeJJmLTU66xKaHCsa37pp+EUQycyUETsYyb1CXP7OTwDmGufxBAwbCB0j5XD56fCmUQJAj0PPmXJHHuc52ufzL3zFz624KuYNz3S/Bo98Rfhx06e1VASe+o55kcbeQszive4cQ1yCaFeU1gGZkdrgpbKjTDZEf0uQ4svhc+arM0ioksZ6XO/DY1LJOHDMrhttC5CR9dZ9m5uUcEeFNibxYKFs1ViYgGuSsNej2P12Mz0kxWntCN9bEYXlktrop+dQmPuC2+tM5D+qvil9M24n8xGoEWafGtyPlIdEsWUc5ITvYVH8hwyWXBJ7k19sys+FBo0WM5BFzm9/uoSEFQGPD52C6QcDsMzYWns340SU5r4GO8sl3PB8OHJhXiPjkwZQPsUdg2Fs4ZL+KYC73yocbRgAJ9GCNfx0PcTfSqSzSteAzZh83Coz4ttacuqEQEdI44MlouxagiaSTBaYdJqF/4ZYc8aBkppMnoUm/MmoyHgDbXPUconVuc5l8vU0wwooi2RccEBCmUMge/ZqtbjZz/bCIQaib4U/g7w7DJWTB603HHwpW7IZEUYp4k+kR1X4czI9kHQ+vTeP8UM1k9X2y/GBYp94vAKAMmOkf7tRmmB7kpKgCQBu66QgMyj+WR8tA5bUH0KFAojshBaxlZEZhQcDRtmMgu1wD9f9YhDt5lpaf40PSC7qxU7w/vmrpCTc3wq5erx8t7cCGeNT7n7mwowoYI=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb93e48-c1f5-422f-6edb-08db24019a3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 20:29:10.4094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: piBMuFIzU3+jrzZMraKV7tNGPKQ7h7uWvztvdCN3I+F+D7rsBNHL0Jf+Cr8NCnP70Im8cBx8V0/QyqdqmPscZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5470
X-Proofpoint-ORIG-GUID: ojLOvQlUWZgpjCCKMXtVf5OZnkujb_VL
X-Proofpoint-GUID: ojLOvQlUWZgpjCCKMXtVf5OZnkujb_VL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_10,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303130161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBNYXIgMTMsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IEFuIHVzYiBk
ZXZpY2UgY2FuIGluaXRhdGUgYSByZW1vdGUgd2FrZXVwIGFuZCBicmluZyB0aGUgbGluayBvdXQg
b2YNCj4gc3VzcGVuZCBhcyBkaWN0YXRlZCBieSB0aGUgREVWSUNFX1JFTU9URV9XQUtFVVAgZmVh
dHVyZSBzZWxlY3Rvci4NCj4gQWRkIHN1cHBvcnQgdG8gaGFuZGxlIHRoaXMgcGFja2V0IGFuZCBz
ZXQgdGhlIHJlbW90ZSB3YWtldXAgY2FwYWJpbGl0eS4NCj4gDQo+IFNvbWUgaG9zdHMgbWF5IHRh
a2UgbG9uZ2VyIHRpbWUgdG8gaW5pdGlhdGUgdGhlIHJlc3VtZSBzaWduYWxpbmcgYWZ0ZXINCj4g
ZGV2aWNlIHRyaWdnZXJzIGEgcmVtb3RlIHdha2V1cC4gU28gYWRkIGFzeW5jIHN1cHBvcnQgdG8g
dGhlIHdha2V1cCBBUEkNCj4gYnkgZW5hYmxpbmcgbGluayBzdGF0dXMgY2hhbmdlIGV2ZW50cy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVsc29uIFJveSBTZXJyYW8gPHF1aWNfZXNlcnJhb0BxdWlj
aW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCAgIHwgIDIgKysNCj4g
IGRyaXZlcnMvdXNiL2R3YzMvZXAwLmMgICAgfCAgNyArKysrKw0KPiAgZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYyB8IDc2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDc5IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCBiMWJkNjMxLi40MTZlMGVmIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
aA0KPiBAQCAtMTExMyw2ICsxMTEzLDcgQEAgc3RydWN0IGR3YzNfc2NyYXRjaHBhZF9hcnJheSB7
DQo+ICAgKgkzCS0gUmVzZXJ2ZWQNCj4gICAqIEBkaXNfbWV0YXN0YWJpbGl0eV9xdWlyazogc2V0
IHRvIGRpc2FibGUgbWV0YXN0YWJpbGl0eSBxdWlyay4NCj4gICAqIEBkaXNfc3BsaXRfcXVpcms6
IHNldCB0byBkaXNhYmxlIHNwbGl0IGJvdW5kYXJ5Lg0KPiArICogQHdha2V1cF9jb25maWd1cmVk
OiBzZXQgaWYgdGhlIGRldmljZSBpcyBjb25maWd1cmVkIGZvciByZW1vdGUgd2FrZXVwLg0KPiAg
ICogQGltb2RfaW50ZXJ2YWw6IHNldCB0aGUgaW50ZXJydXB0IG1vZGVyYXRpb24gaW50ZXJ2YWwg
aW4gMjUwbnMNCj4gICAqCQkJaW5jcmVtZW50cyBvciAwIHRvIGRpc2FibGUuDQo+ICAgKiBAbWF4
X2NmZ19lcHM6IGN1cnJlbnQgbWF4IG51bWJlciBvZiBJTiBlcHMgdXNlZCBhY3Jvc3MgYWxsIFVT
QiBjb25maWdzLg0KPiBAQCAtMTMzMSw2ICsxMzMyLDcgQEAgc3RydWN0IGR3YzMgew0KPiAgDQo+
ICAJdW5zaWduZWQJCWRpc19zcGxpdF9xdWlyazoxOw0KPiAgCXVuc2lnbmVkCQlhc3luY19jYWxs
YmFja3M6MTsNCj4gKwl1bnNpZ25lZAkJd2FrZXVwX2NvbmZpZ3VyZWQ6MTsNCj4gIA0KPiAgCXUx
NgkJCWltb2RfaW50ZXJ2YWw7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMv
ZXAwLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+IGluZGV4IDYxZGU2OTMuLjhhYTE0YTUg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gKysrIGIvZHJpdmVycy91
c2IvZHdjMy9lcDAuYw0KPiBAQCAtMzU2LDYgKzM1Niw5IEBAIHN0YXRpYyBpbnQgZHdjM19lcDBf
aGFuZGxlX3N0YXR1cyhzdHJ1Y3QgZHdjMyAqZHdjLA0KPiAgCQkJCXVzYl9zdGF0dXMgfD0gMSA8
PCBVU0JfREVWX1NUQVRfVTFfRU5BQkxFRDsNCj4gIAkJCWlmIChyZWcgJiBEV0MzX0RDVExfSU5J
VFUyRU5BKQ0KPiAgCQkJCXVzYl9zdGF0dXMgfD0gMSA8PCBVU0JfREVWX1NUQVRfVTJfRU5BQkxF
RDsNCj4gKwkJfSBlbHNlIHsNCj4gKwkJCXVzYl9zdGF0dXMgfD0gZHdjLT5nYWRnZXQtPndha2V1
cF9hcm1lZCA8PA0KPiArCQkJCQlVU0JfREVWSUNFX1JFTU9URV9XQUtFVVA7DQo+ICAJCX0NCj4g
IA0KPiAgCQlicmVhazsNCj4gQEAgLTQ3Niw2ICs0NzksMTAgQEAgc3RhdGljIGludCBkd2MzX2Vw
MF9oYW5kbGVfZGV2aWNlKHN0cnVjdCBkd2MzICpkd2MsDQo+ICANCj4gIAlzd2l0Y2ggKHdWYWx1
ZSkgew0KPiAgCWNhc2UgVVNCX0RFVklDRV9SRU1PVEVfV0FLRVVQOg0KPiArCQlpZiAoZHdjLT53
YWtldXBfY29uZmlndXJlZCkNCj4gKwkJCWR3Yy0+Z2FkZ2V0LT53YWtldXBfYXJtZWQgPSBzZXQ7
DQo+ICsJCWVsc2UNCj4gKwkJCXJldCA9IC1FSU5WQUw7DQo+ICAJCWJyZWFrOw0KPiAgCS8qDQo+
ICAJICogOS40LjEgc2F5cyBvbmx5IGZvciBTUywgaW4gQWRkcmVzc1N0YXRlIG9ubHkgZm9yDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPiBpbmRleCAwNzk4OWM2Li5mMzdmOTQ5IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMN
Cj4gQEAgLTI1OCw3ICsyNTgsNyBAQCBpbnQgZHdjM19zZW5kX2dhZGdldF9nZW5lcmljX2NvbW1h
bmQoc3RydWN0IGR3YzMgKmR3YywgdW5zaWduZWQgaW50IGNtZCwNCj4gIAlyZXR1cm4gcmV0Ow0K
PiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50IF9fZHdjM19nYWRnZXRfd2FrZXVwKHN0cnVjdCBkd2Mz
ICpkd2MpOw0KPiArc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X3dha2V1cChzdHJ1Y3QgZHdjMyAq
ZHdjLCBib29sIGFzeW5jKTsNCj4gIA0KPiAgLyoqDQo+ICAgKiBkd2MzX3NlbmRfZ2FkZ2V0X2Vw
X2NtZCAtIGlzc3VlIGFuIGVuZHBvaW50IGNvbW1hbmQNCj4gQEAgLTMyNSw3ICszMjUsNyBAQCBp
bnQgZHdjM19zZW5kX2dhZGdldF9lcF9jbWQoc3RydWN0IGR3YzNfZXAgKmRlcCwgdW5zaWduZWQg
aW50IGNtZCwNCj4gIA0KPiAgCQkJZmFsbHRocm91Z2g7DQo+ICAJCWNhc2UgRFdDM19MSU5LX1NU
QVRFX1UzOg0KPiAtCQkJcmV0ID0gX19kd2MzX2dhZGdldF93YWtldXAoZHdjKTsNCj4gKwkJCXJl
dCA9IF9fZHdjM19nYWRnZXRfd2FrZXVwKGR3YywgZmFsc2UpOw0KPiAgCQkJZGV2X1dBUk5fT05D
RShkd2MtPmRldiwgcmV0LCAid2FrZXVwIGZhaWxlZCAtLT4gJWRcbiIsDQo+ICAJCQkJCXJldCk7
DQo+ICAJCQlicmVhazsNCj4gQEAgLTIyNjksNiArMjI2OSwyMiBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHVzYl9lcF9vcHMgZHdjM19nYWRnZXRfZXBfb3BzID0gew0KPiAgDQo+ICAvKiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSAqLw0KPiAgDQo+ICtzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9lbmFibGVfbGlu
a3N0c19ldnRzKHN0cnVjdCBkd2MzICpkd2MsIGJvb2wgc2V0KQ0KPiArew0KPiArCXUzMiByZWc7
DQo+ICsNCj4gKwlpZiAoRFdDM19WRVJfSVNfUFJJT1IoRFdDMywgMjUwQSkpDQo+ICsJCXJldHVy
bjsNCj4gKw0KPiArCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0RFVlRFTik7DQo+
ICsJaWYgKHNldCkNCj4gKwkJcmVnIHw9IERXQzNfREVWVEVOX1VMU1RDTkdFTjsNCj4gKwllbHNl
DQo+ICsJCXJlZyAmPSB+RFdDM19ERVZURU5fVUxTVENOR0VOOw0KPiArDQo+ICsJZHdjM193cml0
ZWwoZHdjLT5yZWdzLCBEV0MzX0RFVlRFTiwgcmVnKTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGlu
dCBkd2MzX2dhZGdldF9nZXRfZnJhbWUoc3RydWN0IHVzYl9nYWRnZXQgKmcpDQo+ICB7DQo+ICAJ
c3RydWN0IGR3YzMJCSpkd2MgPSBnYWRnZXRfdG9fZHdjKGcpOw0KPiBAQCAtMjI3Niw3ICsyMjky
LDcgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9nZXRfZnJhbWUoc3RydWN0IHVzYl9nYWRnZXQg
KmcpDQo+ICAJcmV0dXJuIF9fZHdjM19nYWRnZXRfZ2V0X2ZyYW1lKGR3Yyk7DQo+ICB9DQo+ICAN
Cj4gLXN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF93YWtldXAoc3RydWN0IGR3YzMgKmR3YykNCj4g
K3N0YXRpYyBpbnQgX19kd2MzX2dhZGdldF93YWtldXAoc3RydWN0IGR3YzMgKmR3YywgYm9vbCBh
c3luYykNCj4gIHsNCj4gIAlpbnQJCQlyZXRyaWVzOw0KPiAgDQo+IEBAIC0yMzA3LDkgKzIzMjMs
MTMgQEAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X3dha2V1cChzdHJ1Y3QgZHdjMyAqZHdjKQ0K
PiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gIAl9DQo+ICANCj4gKwlpZiAoYXN5bmMpDQo+ICsJCWR3
YzNfZ2FkZ2V0X2VuYWJsZV9saW5rc3RzX2V2dHMoZHdjLCB0cnVlKTsNCj4gKw0KPiAgCXJldCA9
IGR3YzNfZ2FkZ2V0X3NldF9saW5rX3N0YXRlKGR3YywgRFdDM19MSU5LX1NUQVRFX1JFQ09WKTsN
Cj4gIAlpZiAocmV0IDwgMCkgew0KPiAgCQlkZXZfZXJyKGR3Yy0+ZGV2LCAiZmFpbGVkIHRvIHB1
dCBsaW5rIGluIFJlY292ZXJ5XG4iKTsNCj4gKwkJZHdjM19nYWRnZXRfZW5hYmxlX2xpbmtzdHNf
ZXZ0cyhkd2MsIGZhbHNlKTsNCj4gIAkJcmV0dXJuIHJldDsNCj4gIAl9DQo+ICANCj4gQEAgLTIz
MjEsNiArMjM0MSwxMyBAQCBzdGF0aWMgaW50IF9fZHdjM19nYWRnZXRfd2FrZXVwKHN0cnVjdCBk
d2MzICpkd2MpDQo+ICAJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19EQ1RMLCByZWcpOw0K
PiAgCX0NCj4gIA0KPiArCS8qDQo+ICsJICogU2luY2UgbGluayBzdGF0dXMgY2hhbmdlIGV2ZW50
cyBhcmUgZW5hYmxlZCB3ZSB3aWxsIHJlY2VpdmUNCj4gKwkgKiBhbiBVMCBldmVudCB3aGVuIHdh
a2V1cCBpcyBzdWNjZXNzZnVsLiBTbyBiYWlsIG91dC4NCj4gKwkgKi8NCj4gKwlpZiAoYXN5bmMp
DQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICAJLyogcG9sbCB1bnRpbCBMaW5rIFN0YXRlIGNoYW5n
ZXMgdG8gT04gKi8NCj4gIAlyZXRyaWVzID0gMjAwMDA7DQo+ICANCj4gQEAgLTIzNDYsMTMgKzIz
NzMsMzYgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF93YWtldXAoc3RydWN0IHVzYl9nYWRnZXQg
KmcpDQo+ICAJdW5zaWduZWQgbG9uZwkJZmxhZ3M7DQo+ICAJaW50CQkJcmV0Ow0KPiAgDQo+ICsJ
aWYgKCFkd2MtPndha2V1cF9jb25maWd1cmVkKSB7DQo+ICsJCWRldl9lcnIoZHdjLT5kZXYsICJy
ZW1vdGUgd2FrZXVwIG5vdCBjb25maWd1cmVkXG4iKTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+
ICsJfQ0KPiArDQo+ICAJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAt
CXJldCA9IF9fZHdjM19nYWRnZXRfd2FrZXVwKGR3Yyk7DQo+ICsJaWYgKCFkd2MtPmdhZGdldC0+
d2FrZXVwX2FybWVkKSB7DQo+ICsJCWRldl9lcnIoZHdjLT5kZXYsICJub3QgYXJtZWQgZm9yIHJl
bW90ZSB3YWtldXBcbiIpOw0KPiArCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ss
IGZsYWdzKTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJfQ0KPiArCXJldCA9IF9fZHdjM19n
YWRnZXRfd2FrZXVwKGR3YywgdHJ1ZSk7DQo+ICsNCj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3Jl
KCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gIA0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+ICANCj4g
K3N0YXRpYyBpbnQgZHdjM19nYWRnZXRfc2V0X3JlbW90ZV93YWtldXAoc3RydWN0IHVzYl9nYWRn
ZXQgKmcsIGludCBzZXQpDQo+ICt7DQo+ICsJc3RydWN0IGR3YzMJCSpkd2MgPSBnYWRnZXRfdG9f
ZHdjKGcpOw0KPiArCXVuc2lnbmVkIGxvbmcJCWZsYWdzOw0KPiArDQo+ICsJc3Bpbl9sb2NrX2ly
cXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiArCWR3Yy0+d2FrZXVwX2NvbmZpZ3VyZWQgPSAh
IXNldDsNCj4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4g
Kw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3Nl
dF9zZWxmcG93ZXJlZChzdHJ1Y3QgdXNiX2dhZGdldCAqZywNCj4gIAkJaW50IGlzX3NlbGZwb3dl
cmVkKQ0KPiAgew0KPiBAQCAtMjk3OCw2ICszMDI4LDcgQEAgc3RhdGljIHZvaWQgZHdjM19nYWRn
ZXRfYXN5bmNfY2FsbGJhY2tzKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLCBib29sIGVuYWJsZSkNCj4g
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgdXNiX2dhZGdldF9vcHMgZHdjM19nYWRnZXRfb3BzID0gew0K
PiAgCS5nZXRfZnJhbWUJCT0gZHdjM19nYWRnZXRfZ2V0X2ZyYW1lLA0KPiAgCS53YWtldXAJCQk9
IGR3YzNfZ2FkZ2V0X3dha2V1cCwNCj4gKwkuc2V0X3JlbW90ZV93YWtldXAJPSBkd2MzX2dhZGdl
dF9zZXRfcmVtb3RlX3dha2V1cCwNCj4gIAkuc2V0X3NlbGZwb3dlcmVkCT0gZHdjM19nYWRnZXRf
c2V0X3NlbGZwb3dlcmVkLA0KPiAgCS5wdWxsdXAJCQk9IGR3YzNfZ2FkZ2V0X3B1bGx1cCwNCj4g
IAkudWRjX3N0YXJ0CQk9IGR3YzNfZ2FkZ2V0X3N0YXJ0LA0KPiBAQCAtMzgxOSw2ICszODcwLDgg
QEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfZGlzY29ubmVjdF9pbnRlcnJ1cHQoc3RydWN0IGR3
YzMgKmR3YykNCj4gIA0KPiAgCWR3Yy0+Z2FkZ2V0LT5zcGVlZCA9IFVTQl9TUEVFRF9VTktOT1dO
Ow0KPiAgCWR3Yy0+c2V0dXBfcGFja2V0X3BlbmRpbmcgPSBmYWxzZTsNCj4gKwlkd2MtPmdhZGdl
dC0+d2FrZXVwX2FybWVkID0gZmFsc2U7DQo+ICsJZHdjM19nYWRnZXRfZW5hYmxlX2xpbmtzdHNf
ZXZ0cyhkd2MsIGZhbHNlKTsNCj4gIAl1c2JfZ2FkZ2V0X3NldF9zdGF0ZShkd2MtPmdhZGdldCwg
VVNCX1NUQVRFX05PVEFUVEFDSEVEKTsNCj4gIA0KPiAgCWlmIChkd2MtPmVwMHN0YXRlICE9IEVQ
MF9TRVRVUF9QSEFTRSkgew0KPiBAQCAtMzkxMiw2ICszOTY1LDggQEAgc3RhdGljIHZvaWQgZHdj
M19nYWRnZXRfcmVzZXRfaW50ZXJydXB0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJcmVnICY9IH5E
V0MzX0RDVExfVFNUQ1RSTF9NQVNLOw0KPiAgCWR3YzNfZ2FkZ2V0X2RjdGxfd3JpdGVfc2FmZShk
d2MsIHJlZyk7DQo+ICAJZHdjLT50ZXN0X21vZGUgPSBmYWxzZTsNCj4gKwlkd2MtPmdhZGdldC0+
d2FrZXVwX2FybWVkID0gZmFsc2U7DQo+ICsJZHdjM19nYWRnZXRfZW5hYmxlX2xpbmtzdHNfZXZ0
cyhkd2MsIGZhbHNlKTsNCj4gIAlkd2MzX2NsZWFyX3N0YWxsX2FsbF9lcChkd2MpOw0KPiAgDQo+
ICAJLyogUmVzZXQgZGV2aWNlIGFkZHJlc3MgdG8gemVybyAqLw0KPiBAQCAtNDA2NCw3ICs0MTE5
LDcgQEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfY29ubmRvbmVfaW50ZXJydXB0KHN0cnVjdCBk
d2MzICpkd2MpDQo+ICAJICovDQo+ICB9DQo+ICANCj4gLXN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0
X3dha2V1cF9pbnRlcnJ1cHQoc3RydWN0IGR3YzMgKmR3YykNCj4gK3N0YXRpYyB2b2lkIGR3YzNf
Z2FkZ2V0X3dha2V1cF9pbnRlcnJ1cHQoc3RydWN0IGR3YzMgKmR3YywgdW5zaWduZWQgaW50IGV2
dGluZm8pDQo+ICB7DQo+ICAJLyoNCj4gIAkgKiBUT0RPIHRha2UgY29yZSBvdXQgb2YgbG93IHBv
d2VyIG1vZGUgd2hlbiB0aGF0J3MNCj4gQEAgLTQwNzYsNiArNDEzMSw4IEBAIHN0YXRpYyB2b2lk
IGR3YzNfZ2FkZ2V0X3dha2V1cF9pbnRlcnJ1cHQoc3RydWN0IGR3YzMgKmR3YykNCj4gIAkJZHdj
LT5nYWRnZXRfZHJpdmVyLT5yZXN1bWUoZHdjLT5nYWRnZXQpOw0KPiAgCQlzcGluX2xvY2soJmR3
Yy0+bG9jayk7DQo+ICAJfQ0KPiArDQo+ICsJZHdjLT5saW5rX3N0YXRlID0gZXZ0aW5mbyAmIERX
QzNfTElOS19TVEFURV9NQVNLOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBkd2MzX2dhZGdl
dF9saW5rc3RzX2NoYW5nZV9pbnRlcnJ1cHQoc3RydWN0IGR3YzMgKmR3YywNCj4gQEAgLTQxNTcs
NiArNDIxNCwxMiBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9saW5rc3RzX2NoYW5nZV9pbnRl
cnJ1cHQoc3RydWN0IGR3YzMgKmR3YywNCj4gIAl9DQo+ICANCj4gIAlzd2l0Y2ggKG5leHQpIHsN
Cj4gKwljYXNlIERXQzNfTElOS19TVEFURV9VMDoNCj4gKwkJaWYgKGR3Yy0+Z2FkZ2V0LT53YWtl
dXBfYXJtZWQpIHsNCj4gKwkJCWR3YzNfZ2FkZ2V0X2VuYWJsZV9saW5rc3RzX2V2dHMoZHdjLCBm
YWxzZSk7DQo+ICsJCQlkd2MzX3Jlc3VtZV9nYWRnZXQoZHdjKTsNCj4gKwkJfQ0KPiArCQlicmVh
azsNCj4gIAljYXNlIERXQzNfTElOS19TVEFURV9VMToNCj4gIAkJaWYgKGR3Yy0+c3BlZWQgPT0g
VVNCX1NQRUVEX1NVUEVSKQ0KPiAgCQkJZHdjM19zdXNwZW5kX2dhZGdldChkd2MpOw0KPiBAQCAt
NDIyNSw3ICs0Mjg4LDcgQEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfaW50ZXJydXB0KHN0cnVj
dCBkd2MzICpkd2MsDQo+ICAJCWR3YzNfZ2FkZ2V0X2Nvbm5kb25lX2ludGVycnVwdChkd2MpOw0K
PiAgCQlicmVhazsNCj4gIAljYXNlIERXQzNfREVWSUNFX0VWRU5UX1dBS0VVUDoNCj4gLQkJZHdj
M19nYWRnZXRfd2FrZXVwX2ludGVycnVwdChkd2MpOw0KPiArCQlkd2MzX2dhZGdldF93YWtldXBf
aW50ZXJydXB0KGR3YywgZXZlbnQtPmV2ZW50X2luZm8pOw0KPiAgCQlicmVhazsNCj4gIAljYXNl
IERXQzNfREVWSUNFX0VWRU5UX0hJQkVSX1JFUToNCj4gIAkJaWYgKGRldl9XQVJOX09OQ0UoZHdj
LT5kZXYsICFkd2MtPmhhc19oaWJlcm5hdGlvbiwNCj4gQEAgLTQ0NzgsNiArNDU0MSw3IEBAIGlu
dCBkd2MzX2dhZGdldF9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJZHdjLT5nYWRnZXQtPnNn
X3N1cHBvcnRlZAk9IHRydWU7DQo+ICAJZHdjLT5nYWRnZXQtPm5hbWUJCT0gImR3YzMtZ2FkZ2V0
IjsNCj4gIAlkd2MtPmdhZGdldC0+bHBtX2NhcGFibGUJPSAhZHdjLT51c2IyX2dhZGdldF9scG1f
ZGlzYWJsZTsNCj4gKwlkd2MtPmdhZGdldC0+d2FrZXVwX2NhcGFibGUJPSB0cnVlOw0KPiAgDQo+
ICAJLyoNCj4gIAkgKiBGSVhNRSBXZSBtaWdodCBiZSBzZXR0aW5nIG1heF9zcGVlZCB0byA8U1VQ
RVIsIGhvd2V2ZXIgdmVyc2lvbnMNCj4gLS0gDQo+IDIuNy40DQo+IA0KDQpBY2tlZC1ieTogVGhp
bmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==
