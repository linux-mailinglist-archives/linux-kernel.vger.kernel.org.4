Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A64672F06
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjASCcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjASCck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:32:40 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00981A24E;
        Wed, 18 Jan 2023 18:32:39 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30INrZsV004909;
        Wed, 18 Jan 2023 18:32:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=jkOqSufGV4j21gSwCgNaBY3FRQo2XdfI8uH0Uiu/kjU=;
 b=jjrdi45Ys/YM/lf7TvBPWdUGlBaScGh+d35ugUzQUbe9m9/W7l00s+NG13KHE1TL94K7
 5gahNJJTviiMLSLyVuCnNwCXO2uTTGlzm5mqtjK8h7foFD36CFCL4nHv2eCW6zwMG14O
 MMGy5hfDPbNaH4vP/imc5Nmq6zlRFGK9P6ilH5oF/1XifrrSNpTOWENGHAZbwV175UD6
 58zmDrq6EZ4VxzrPNnytjm6blvIOyLLzbcQu5pPdiuNcwYTFmONPagsm9VQFWpN6vLoj
 MJ/GbBQDERxaSSGu2sVROECCVs1/xvqQh5u+3Ijf5DEqBHDnj7YKZxLKg2J5J+ab/4Xr vg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3n3uwmhxv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 18:32:28 -0800
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8025DC098D;
        Thu, 19 Jan 2023 02:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674095547; bh=jkOqSufGV4j21gSwCgNaBY3FRQo2XdfI8uH0Uiu/kjU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fQk1H61ITVun04/DAEBUoGkyTnCJ2dKfBXVPqV6eUQFZ9TBt+9KgdZYuYtcAPhZBq
         6XjysVHA+QDTBVPGJYm7eSs8/1fLNziWRg9gHjcE3vuK/EGi+DA3V2X7T+sQMSrpkC
         RU6uaox2mtcA7LfbAohykTivsXmhHTeOD2eXHbOmipUKKPwn4mdUoyMAk3opCVSXrw
         EutTQesAaqYL38orLbR8Sx3My9b0N4bsmN8a7gr67wUqIeRkLlieIgY5UV9FDA3B8t
         BmALmb4swvITguLEQupvR+q2KLdY9g45wn+a9DcJ4vnDoqDM+cQ0cWTnDz+NPrFSQW
         C10i+advrdv9g==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7FD38A0068;
        Thu, 19 Jan 2023 02:32:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 807D64006B;
        Thu, 19 Jan 2023 02:32:24 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="oYCuwfZb";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zgir3OUHiyWXXlfcwgEBHwb57qgsms5NsxAuRsZSbkc+EsWW86OXVlm3i7qUZZwdWNQTTV64p9tQhb94jbZeo43dOPxhR0U6j/EUkrkrvDcsSY8iE7fYESwJlKgbe47QZb+QEXwWN7mf+t42C7nMlGAwjEM1VXpdskdxdCTvisyW79ZrlDXMd4TfOzT1jORep3EVjfcoCP9TIykdw6cW6bJIKAUztopPa5qNycXQw8eip8GKR7dtiGDzZy9EHt7exCMnfClpis4BOQn5KGWo9QjMmGOt0JfxvZeLRZsdyyiQBBkNgzDqiA398sGGenQ2WjEyuwUJDmfOyB6KCRM2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkOqSufGV4j21gSwCgNaBY3FRQo2XdfI8uH0Uiu/kjU=;
 b=naPGQ5FgFkWrBug6dHXvdIxI0svb2hr9A22046Gg7cYXAdMrKGKA6kF8NRoFDRiQSfxzbkrh/M98gj36muzY/XCyNgtjJt9fW1qzZXcbroPTuDcQxUic62BRdsfd7pozdB4RFIAeNASOkiqbTtAgaGJKAdBwCDlZrjEqoEytuJK+6AFRAT5UOTFGI4NeadW6xkuYygCnZUQptyWbQewQsVPCr4Wi+mKM0/2EVXlFMna42y8QfsEz0P1QFFIN84JNdVSKAHznjy9o36WC42Rop6HpfW3KRc1qcPeBHtpjODM4evlq15Msyhx0tLgKIi87jcRTjiw/8Lmbi086fuIQvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkOqSufGV4j21gSwCgNaBY3FRQo2XdfI8uH0Uiu/kjU=;
 b=oYCuwfZb4LKLx5DM8JpYQYAybfjentutpsP/vSLwNaAT/cuiuaH3bO1anbwvHf1+0rqOURqXtw1orI3l2U99j5Ai6mEf7Odwh7ILlWUxm3ipvZjE5qpXjbrJC/TFFbRRBYspf1Nro6Gz0YSex5d2lYkyAjq2BgyJnA1PdrQxM9o=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB8523.namprd12.prod.outlook.com (2603:10b6:8:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 02:32:22 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee%4]) with mapi id 15.20.5986.018; Thu, 19 Jan 2023
 02:32:21 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jack Pham <quic_jackp@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>
Subject: Re: [RFC v4 3/5] usb: dwc3: core: Do not setup event buffers for host
 only controllers
Thread-Topic: [RFC v4 3/5] usb: dwc3: core: Do not setup event buffers for
 host only controllers
Thread-Index: AQHZKNZzK80dA+KuD0GE1952O2kzEa6k6x8AgAAV7YCAAAnEAA==
Date:   Thu, 19 Jan 2023 02:32:21 +0000
Message-ID: <20230119023216.q73djy4zdolhg325@synopsys.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
 <20230115114146.12628-4-quic_kriskura@quicinc.com>
 <20230119003850.id3gtcokdim5pvf7@synopsys.com>
 <20230119015535.GF28337@jackp-linux.qualcomm.com>
In-Reply-To: <20230119015535.GF28337@jackp-linux.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB8523:EE_
x-ms-office365-filtering-correlation-id: 6f8ea2d0-31b5-4e4c-5686-08daf9c56487
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FHqZ2xWaufMVoR8dklBXhbvI+bzqOBz6rbzhXtV5iOj8yg30bxX7q3yhmh0AG+2dlxSEyRODMBzw85ElkxUmShE9N6TZxOHmc3HJOUFblAuCtqNv4beQf50n5lfkXjhKKsT6fO4X64S4cXUOi7xhbUx6yLIRYepAxWlRs/pS9E4M2Pfl3S/ZmMpmktY2/J3M0/z/fvgjvWagpoB/KAQYE57hic/7OJnOcYYdrfwqMoo9rKfAacrjggmqT+j96n9sqaO6xShg9LIm/Qjgt5BrKEmKHhl+xYLTVoPxc1rYpdFQ6oPRcnILV6f+EzW3ex+5Ra7vNdNaXcipTu+Pd+TeDYc4cyN4i3IBh0CPPtfWJ60PoWHGKVaEVPoc0V+lxLq+TgNdFifUQyzKlE9SXs4XY8tunmtiofNLU9qpI04/lRFDd203YXac5la1Ady4VXz0r7WuOTP/P8+5lh8bdyxd0SbfBo1rKA12Au3hJIvWFO+Yn8CKiTOz2cen+VAQnWmpFdzbdnGH/iOytCAhAXMymz5TMBwj70VPmVBUmofL+Jx1HWMOWpprZLtWnq2D609iTPmBVDWcJL3t+GFy47M6F7RsM54+ZJznIn3SuFzuzw4h8gqrRM/lqOgIPyUAbzOPgtZEYpJUGvbhfrECUruAOt6GFuwkvkSH2wEmLADjVXsE7yRmFg0ZAGYOXa2oDZM3ZQdkK0NXiEcDRhNGNuqJyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(64756008)(66946007)(38100700002)(122000001)(66556008)(8936002)(2906002)(5660300002)(66476007)(7416002)(76116006)(66446008)(4326008)(6916009)(41300700001)(8676002)(2616005)(1076003)(186003)(26005)(83380400001)(6512007)(71200400001)(316002)(54906003)(6486002)(38070700005)(478600001)(36756003)(6506007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnpjYklpeXJZSks0OE9SQzNVUGRXYjVmcU5pVDlwaUxrR09yOVVqTkFmeFVK?=
 =?utf-8?B?cnBoaVFYVjc4a2RXS2EzM216UUhuL0hBUElGQW1jQ1BUeTNZMVdJeE52YTdq?=
 =?utf-8?B?NG1BTDcwekthM1NIUGRkRW9iYSt6U0tQeUJpMlU5S2RjNUlDcVgwVHRnVnZG?=
 =?utf-8?B?aHBvY2VrOHkybzZDY1oyVHIyN3FQVHVhcDRIMkNzd0VuWlBGZE1TSVJ1MDV4?=
 =?utf-8?B?MXIzcURqYWxjY0N4ckFMdzQvRlFkZ2tKYXRIS01yWnBoWTNDSGJBaDRwZDQ5?=
 =?utf-8?B?RTJUbkJ1dWMrL1YyWVVYQUFHMEVUL3EwVzJ5VjIzekcwTW05c2duZ2pOazNK?=
 =?utf-8?B?N01Zckx1bjdlMmMwNnFMS2RUaDZ5MldIUnlUQUF2QVhjM0JjSzZPM3dmV29I?=
 =?utf-8?B?MW9hRU9TR2VkV2VZaHh0dng5SndSWks2cG1OUW5Qanh5b3RnQlVhMlcyRjVs?=
 =?utf-8?B?bFA0YWZuSXNvVk5kZy9EcDdaeERVK1k3ckJ2ZTQxbHhZUDk2NXNkcnpFMk84?=
 =?utf-8?B?UWlTeitzUXZteXYzYUR5MTgzSnk3Y2ZzR0lWQzVYS085eWZ0N0lzUzRRUFQy?=
 =?utf-8?B?T0lRMmxiWU5yaWtJdDFTYjJEVGtrL2NEWjhRdTJuQ3YwbVphMEk3b2RaaVFx?=
 =?utf-8?B?Q3EyOWU1Qk1mRkx4Vncza2M2NmFENVYwNlhGOTk4QmU0UWxyMFJ0citibjdt?=
 =?utf-8?B?VTIxQ2ZuV1pYWWxxbWx3d3dyWnFWdkNCMkxaMWJhSkNwMjQ2a2NqV3U0TERI?=
 =?utf-8?B?Y1IyeENBamFSVkRHNEhMamt5eHRyNldmbmxveUxoVU5SVldOd1RkMTRjZkZH?=
 =?utf-8?B?clFJbUN2cy8wOG8yL0NEM1pFSlI4c01tSlNzcWVHTmplL3pnQ0dLU0N2a0pa?=
 =?utf-8?B?c3h0OEptTmpFRFRVQWpHcW1OWUR0WTRnNlpTSUZWNjFudllOcURuMktiWVgy?=
 =?utf-8?B?bDg1cFNkWE9ZdjBSWkRST2cwTWw1dkFEbTNnT0Zyam1sTHJDMTdKdndHbEJ2?=
 =?utf-8?B?QXQyRlhWcTFvVTVVSUlTNjdVYVBnWFFCc0FTQkY5L0RuaGt3RjhBenM3b2Yx?=
 =?utf-8?B?Zk1JeDNzS2dYdWRhM2RwamlRTzBpVmFBK1NTRnhOYXcva3dGSWVNcmx4NWJZ?=
 =?utf-8?B?eGRIWEpiUlZ2aG94SmRPR3pPK2p2dkYzY3d3ZmFaZGo3b3QvUlFHc3ZJcUpL?=
 =?utf-8?B?WXp0MlZTOTFkNGJ4Nkx5Y24wdldZNTVVZjIyell4TncvbTMvME5ldk5kYmZh?=
 =?utf-8?B?OEZlQWlTMTRkRG5Md2ljcC9MYTlPMGtzZXhJRjQwMmFxUGhMcVJzelRRQ1RU?=
 =?utf-8?B?Q2g2ZEdvN3Z2UjhyNjREcml2V1pKYk5CaGVuRURDK3djd0FQOTN2bzF4NVJy?=
 =?utf-8?B?TXZPSDZUTUdSTTZoMFpmOUpOT0FYN1M0QXBwUHFjTmYyLzRkVVUxQW9JS2Fq?=
 =?utf-8?B?M0lwVVQ1UXlHMi9hN05NRGJONWhLRzlUUkhDQ2V1T1BiRzZIY05CcSsxbVZR?=
 =?utf-8?B?T3Z5OEtqVkoxdDNlSWs0ek1lbUlXZVk0SytKTXFiWXFSV3A4RzBBZHdtcDdO?=
 =?utf-8?B?ZWdqemtYb0lmK3F0NDRCWlB6UEgxVWk2a0draU5CbWRCdGwxK2lqVlFRVW15?=
 =?utf-8?B?SHJYUlJLV3lyMUVkNTljc3ZzdzZ0RmRodXFYTEh1MEdtR2ZFN0daTzhsSjR5?=
 =?utf-8?B?NEx0TCs3YUswREljQ2VTOXdNWWo3UFlzNkVvb1U4RS8vYmVvZnVjaGNzQ0V1?=
 =?utf-8?B?bEdaV2d6bFlkS05NZTl1TWllTnpmeUEyY1AxM2J4UnA5a2RkNmZtcGtvV2Fi?=
 =?utf-8?B?RHQxMlUveHFmeEJnZmlvS0Z3NlNEUDVCeFR4eDhDN0dWZmZhcy94VVpzeWta?=
 =?utf-8?B?UGEzbjIrVkU0cDh4cGxqcG5hVGRNWmpWbytmekU5WUEwRXFIQUhlclBzSTZI?=
 =?utf-8?B?d0tpY2JmM1JMaHVvNWJRRXl0Y2xIT3E4MDBIM2tXYVhUTmltYzBSTnIvU0Fu?=
 =?utf-8?B?eUNMSVQzU05jUXg5eVFDaFhaWkd4VTBUUXhBcDZMb090Sko3UjdoS1JJMjVN?=
 =?utf-8?B?M1AxT21PMUtIbGlENllZUnFTVDF4bzIvV0hVclFLYW1QYnN0TGFkdXJHVXA5?=
 =?utf-8?B?ZkFZK2dWek1qeTBIbTkzVk1VN1JjeWxhMmNPTXUrTXViRUN5R2JxU1BLeC90?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D24A4207FF89444AA40724703C4AC75E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L1pheXFsM0F0QktGQ0xmeDhoWlhwRm4zeXdGZXovUzdFQ3krKzFCeTY0S1N3?=
 =?utf-8?B?cGFkM2QyTG1hNzhLL0h1K1kvUW5YQmRROWN4RmtEd2d6NXpFWk1rOTRkeXZN?=
 =?utf-8?B?Qy94TVVSRyt6UGZJVmQ4aUYvWnBTdGlOY3VFaUo2LzN5UFBHQ3hYZ09sRk9U?=
 =?utf-8?B?U2FEUElzNjJPWlcxUE9qSHFXVEs0c2N1V291bUQvTVh5YmtqaXVKQVgyY1RQ?=
 =?utf-8?B?TjVKSzhvcEdZNmxWWEhKRzk3amtHL01GOXRKYUl2SkJsQ1FieG1uVFlvekJS?=
 =?utf-8?B?T2p5SDlTWW9pTGo3YjVza2tQNDlwckJxbnRRZWlVUmFZUTBPTFNPRXdONVJ6?=
 =?utf-8?B?NGxRbkY3a1JEV280K2NSOHRBTFpoaGk1Tm9NL3lVQ1I0bnpvaXNXZmZJV1pm?=
 =?utf-8?B?Q3pRczRWVjdtdVlJTU1neHVVTlNFdTlqdDMvZDMwN1YxQTQ1bHNMTGlmS2tO?=
 =?utf-8?B?Z1NVbEZQc3d4LzdFRGtpbFF6OWZNVXJoU1ZOR3NVL2VoYnNrYmduaFV2RitP?=
 =?utf-8?B?UWxsVE9UYndRa0RDN3hPQUtlTEh4UGRLNXRRWFJGUTdYc0tUVEEwSVRNWDli?=
 =?utf-8?B?SUNLaTR2UlZLOVVIa3FLdDA0RGR6a3JVejFyS2NVVHVHWnpQSTJOa3BOWVl4?=
 =?utf-8?B?blJxYTZGYk5qV1RST3h2aURmdGtNWVRvK2orTnZFSnlUTzVpeGhkK1oxZ2Rq?=
 =?utf-8?B?RE8xV3d0K1Q2SzE1dk9pMWpFbmtqYXo5ZmpSL1gxVENtSWVxTmNJZDYrSGdq?=
 =?utf-8?B?ZVp0QXk5QXNsKzRGK3pVQWZUNjAyM1oxaVdGUlVlSE9IWDVrdEU5Zk1yaHBZ?=
 =?utf-8?B?UllKK1hYZFJCWlFoY2I2MnNlTGU4ajlKbW1zeFh3QUthekJ0NCs0R1ZTVGdT?=
 =?utf-8?B?Tm1VT3ZINW9uSUQ3bW4yU0loVWJ2Wkp5M3hUazVUTGNlQjFLVTJqK3g2NDg3?=
 =?utf-8?B?V2VzSDRVdllHczdhZDNRR0lqczZoK1VwLzhyQVRwZzdIQkVwY1VHdG91NkFt?=
 =?utf-8?B?OUlMTTRldFpxMDBoekM5SkgvVlVyc0lmYnd4SXA4WDhlT2F0RENQK0U2ODlQ?=
 =?utf-8?B?ZGlTaFpOM1RoNFBOb2w0ZWZPVHdkZ08veEZJeEZrUkZIRHZVaHpGaC9MZmVk?=
 =?utf-8?B?NFZuSDhMT0VZc091QUZlZVpnc1NqK3A0cGZMbm12Nzc2YkpMQ2JjeXRPeE9n?=
 =?utf-8?B?TkNhUGE3TEtHRjczRFpjZ2FNUi9BWWJTWHBDa1NYdFlQU2pFcE5BM0FYVWx3?=
 =?utf-8?B?R2F6NFVXcm9qT0RLd3lOdm9GNHZaNEtIVzhUVXRuaWZMTFhiUGUrb0RqdGNk?=
 =?utf-8?Q?0TQGwyvSmxlQ4=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8ea2d0-31b5-4e4c-5686-08daf9c56487
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 02:32:21.6498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l89iHYrjTN7DZ9/Es1s1J/p3zirO+wji2J2lkimijQK8NMiUYJqTgiLjr76cbUBuEfkNRqvWbIZsGFxVbCk8yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8523
X-Proofpoint-ORIG-GUID: fP57oaVDAesLRsnrC_IrHXhWJ3gDK26y
X-Proofpoint-GUID: fP57oaVDAesLRsnrC_IrHXhWJ3gDK26y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301190014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKYW4gMTgsIDIwMjMsIEphY2sgUGhhbSB3cm90ZToNCj4gSGkgVGhpbmgsDQo+IA0K
PiBPbiBUaHUsIEphbiAxOSwgMjAyMyBhdCAxMjozODo1MUFNICswMDAwLCBUaGluaCBOZ3V5ZW4g
d3JvdGU6DQo+ID4gT24gU3VuLCBKYW4gMTUsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6
DQo+ID4gPiBNdWx0aXBvcnQgY29udHJvbGxlcnMgYmVpbmcgaG9zdC1vbmx5IGNhcGFibGUgZG8g
bm90IGhhdmUgR0VWTlRBRERSDQo+IA0KPiBNdWx0aXBvcnQgbWF5IG5vdCBiZSByZWxldmFudCBo
ZXJlLiAgSG9zdC1vbmx5IGlzIHRob3VnaC4NCj4gDQo+ID4gPiBISS9MTywgU0laRSwgQ09VTlQg
cmVpZ3N0ZXJzIHByZXNlbnQuIEFjY3Nlc2luZyB0aGVtIHRvIHNldHVwIGV2ZW50DQo+ID4gDQo+
ID4gSSB0aGluayB5b3Ugc2hvdWxkIHJld29yZCAicHJlc2VudCIgdG8gc29tZXRoaW5nIGVsc2Uu
IFRoZXkncmUgc3RpbGwNCj4gPiBwcmVzZW50DQo+IA0KPiBJbiBvdXIgY2FzZSB3ZSBoYXZlIGFu
IGluc3RhbmNlIHdoZXJlIHRoZSBJUCBpcyBzdGF0aWNhbGx5IGNvbmZpZ3VyZWQNCj4gdmlhIGNv
cmVDb25zdWx0YW50IHdpdGggRFdDX1VTQjMxX01PREU9PTEgKGhvc3Qgb25seSkgYW5kIHdlIGRp
ZCBvYnNlcnZlDQo+IHRoYXQgbm9uZSBvZiB0aGUgcmVnaXN0ZXJzIHBlcnRhaW5pbmcgdG8gZGV2
aWNlIG1vZGUgKGluY2x1ZGluZyBHRVZOVCoNCj4gYW5kIG9mIGNvdXJzZSBhbGwgdGhlIEQqIG9u
ZXMpIGFyZSBldmVuICpwcmVzZW50KiBpbiB0aGUgcmVnaXN0ZXIgbWFwLg0KPiBJZiB3ZSB0cnkg
dG8gYWNjZXNzIHRoZW0gd2UgZW5jb3VudGVyIHNvbWUga2luZCBvZiBhY2Nlc3MgZXJyb3Igb3Ig
c3RhbGwNCj4gKG9yIHRyYW5zbGF0aW9uIGZhdWx0IGFzIGRlc2NyaWJlZCkuICBTbyB0aGUgYXBw
cm9hY2ggaGVyZSBpcyB0byBmaXJzdA0KPiB2ZXJpZnkgYnkgY2hlY2tpbmcgdGhlIEhXUEFSQU1T
MCByZWdpc3RlciBpZiB0aGUgSFcgaXMgZXZlbiBjYXBhYmxlIG9mDQo+IGRldmljZSBtb2RlIGlu
IHRoZSBmaXJzdCBwbGFjZS4NCg0KSSBzZWUuDQoNCj4gDQo+ID4gYnV0IHRob3NlIHJlZ2lzdGVy
cyBhcmUgdG8gYmUgc2V0IHdoaWxlIG9wZXJhdGluZyBpbiBkZXZpY2UNCj4gPiBtb2RlLiBUaGUg
cmVzdCBsb29rcyBmaW5lLg0KPiANCj4gQXJlIHlvdSBzdWdnZXN0aW5nIG9ubHkgdG91Y2hpbmcg
dGhlIEdFVk5UKiByZWdpc3RlcnMgd2hlbiAqb3BlcmF0aW5nKg0KPiBpbiBkZXZpY2UgbW9kZSwg
ZXZlbiBpbiB0aGUgY2FzZSBvZiBhIGR1YWwtcm9sZSBjYXBhYmxlIGNvbnRyb2xsZXI/ICBJbg0K
PiB0aGF0IGNhc2Ugd291bGQgaXQgbWFrZSBtb3JlIHNlbnNlIHRvIGFkZGl0aW9uYWxseSBtb3Zl
IHRoZSBjYWxscyB0bw0KPiBkd2MzX2V2ZW50X2J1ZmZlcnNfe3NldHVwLGNsZWFudXB9IG91dCBv
ZiBjb3JlLmMgYW5kIGludG8NCj4gZHdjM19nYWRnZXRfe2luaXQsZXhpdH0gcGVyaGFwcz8gIFRo
YXQgd2F5IHdlIGF2b2lkIHRoZW0gY29tcGxldGVseQ0KDQpXaGlsZSBpdCBzaG91bGRuJ3QgYmUg
YSBwcm9ibGVtIGZvciBEUkQsIGl0IG1heSBiZSBjbGVhbmVyIHRvIGRvIHRoYXQuDQoNCj4gdW5s
ZXNzIGFuZCB1bnRpbCB3ZSBzd2l0Y2ggaW50byBwZXJpcGhlcmFsIG1vZGUgKGFzc3VtaW5nIGNv
bnRyb2xsZXINCj4gc3VwcG9ydHMgdGhhdCwgd2hpY2ggd2Ugc2hvdWxkIGFscmVhZHkgaGF2ZSBj
aGVja3MgZm9yKS4gIE1vcmVvdmVyLCBpZg0KPiB0aGUgZGV2aWNldHJlZSBkcl9tb2RlIHByb3Bl
cnR5IGlzIHNldCB0byBob3N0LW9ubHkgd2UnZCBhbHNvIGF2b2lkDQo+IGNhbGxpbmcgdGhlc2Uu
DQo+IA0KPiA+ID4gYnVmZmVycyBkdXJpbmcgY29yZV9pbml0IGNhbiBjYXVzZSBhbiBTTU1VIEZh
dWx0LiBBdm9pZCBldmVudCBidWZmZXJzDQo+ID4gPiBzZXR1cCBpZiB0aGUgR0hXUEFSQU1TMCB0
ZWxscyB0aGF0IHRoZSBjb250cm9sbGVyIGlzIGhvc3Qtb25seS4NCj4gPiA+IA0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogS3Jpc2huYSBLdXJhcGF0aSA8cXVpY19rcmlza3VyYUBxdWljaW5jLmNvbT4N
Cj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMjMgKysrKysrKysr
KysrKysrLS0tLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwg
OCBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+IGluZGV4IDdlMGE5YTU5
OGRmZC4uZjYxZWJkZGFlY2MwIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiBAQCAtODcx
LDkgKzg3MSwxMiBAQCBzdGF0aWMgdm9pZCBkd2MzX2Nsa19kaXNhYmxlKHN0cnVjdCBkd2MzICpk
d2MpDQo+ID4gPiAgDQo+ID4gPiAgc3RhdGljIHZvaWQgZHdjM19jb3JlX2V4aXQoc3RydWN0IGR3
YzMgKmR3YykNCj4gPiA+ICB7DQo+ID4gPiAtCWludCBpOw0KPiA+ID4gKwlpbnQJCWk7DQo+ID4g
PiArCXVuc2lnbmVkIGludAlod19tb2RlOw0KPiA+ID4gIA0KPiA+ID4gLQlkd2MzX2V2ZW50X2J1
ZmZlcnNfY2xlYW51cChkd2MpOw0KPiA+ID4gKwlod19tb2RlID0gRFdDM19HSFdQQVJBTVMwX01P
REUoZHdjLT5od3BhcmFtcy5od3BhcmFtczApOw0KPiA+ID4gKwlpZiAoaHdfbW9kZSAhPSBEV0Mz
X0dIV1BBUkFNUzBfTU9ERV9IT1NUKQ0KPiANCj4gSWYgd2Ugc3RpY2sgd2l0aCB0aGlzIGFwcHJv
YWNoLCB3ZSBwcm9iYWJseSBjb3VsZCBqdXN0IGNoZWNrDQo+IGR3Yy0+ZHJfbW9kZSBpbnN0ZWFk
IGFzIHByb2JlIHNob3VsZCBoYXZlIGFscmVhZHkgc2V0IHRoYXQgdG8gYmUgYW4NCj4gaW50ZXJz
ZWN0aW9uIGJldHdlZW4gdGhlIHZhbHVlcyBnaXZlbiBpbiBkZXZpY2V0cmVlICJkcl9tb2RlIiBh
bmQgdGhlDQo+IEhXUEFSQU1TMCBjYXBhYmlsaXR5Lg0KPiANCg0KV2hhdCB3ZSBoYXZlIGhlcmUg
c2hvdWxkIG5vdCBicmVhayBEUkQsIHNvIGl0J3MgZmluZSBlaXRoZXIgd2F5Lg0KDQpUaGFua3Ms
DQpUaGluaA==
