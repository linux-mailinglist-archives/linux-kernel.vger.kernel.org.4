Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF0270765B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjEQXWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjEQXWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:22:18 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2C52D47;
        Wed, 17 May 2023 16:22:17 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HMtI1F027611;
        Wed, 17 May 2023 16:22:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=a+s+FiRvl26AMlqx/feNN+g7mWF46Urr8/dHevO4uWM=;
 b=pKB3bwtt+HlMfhyzepO0iTnTV4kScnrHaKbx3O9Y5RSgUM9g9Qeay6qb/I0EivQVQEGz
 6ys9pDYdmcoZhzDEDn7jN8e/QyyXWl3EVWvWxkNe70IwxtNyGYxwhYI0KdJU+ygRBzN/
 zl23lVGqdE7qLuXcj9WmbszHqHaJ7rEGe1df9VDB5yk0tSqoiGk5Pbp2rlUzQFLy/L5i
 dnsRWu1LGwYL707xbKR3Zkfi24NXzuamnGXDUuJgk3pqEx0++0AAAQ0/tU84kf1tM9yu
 oP4QFaO3urNod/gStd/TKTcFLbIQYMkGFEMnMXFQVDvcPHJaYnSVlj2ooecEwgJx0q8d aQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3qj9t4x1h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 16:21:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1684365719; bh=a+s+FiRvl26AMlqx/feNN+g7mWF46Urr8/dHevO4uWM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MWiHZXjoJaSgJ7gSrT+KQHjQE11ucmi3uvRoOAV4NXapjGN0FIIUvSCmfIRWox3A9
         XYwjnMkMEAANMQwjelR65Zhfg72zr6bMdrVMD3Qs4eR53Zmvlqxmz/IZqu617tTu5u
         yhSp/+B9rPFd/+LLZWu+4eZ3tibs/T63/7R6eezlfN00A8lwhTKhJOcJGAP7UZzr3p
         pOuq4qxDfdyhElCR2M8BNEs/+74PsUclxZOjoOGn4dw1ByjZK8aHpCWV1YtTUiSa6r
         VNgUKcSvC2BBSo2RcvqdHq/whFo/fPjFxqEnBzeM/WOM3gukCFIDrNSaxjRArhJ+l9
         s0PLRAIndpN4w==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CA826404A8;
        Wed, 17 May 2023 23:21:57 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id CDD23A006D;
        Wed, 17 May 2023 23:21:56 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=CvThzLC9;
        dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7049140637;
        Wed, 17 May 2023 23:21:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEY9f5mGLrFStcrR6/rgK2FbLMgtlA2ocEENa9XqurYMzxgl3jFnMQYpbfjWSbhJfBt3VhRmoOJd30QGl0NCgi9FTwl6JSh3N+9DBD1C4Qq0hxkZAZutv1ZYtw/bUm77rgqzWQi8BLacXeFimJDRFCG0d/7DLSeFGFtJqdO7coAYqpeHIfXm4vqB+TRQ2iZDsojajgvnMtjyo6vTrjxtRSzabdusAvuHMvhHPMNj9LFlR8sczu1xEAww5kKKxSi7VDrk0lEDQ/DuE0Vt9IP+anDijj8OASENZTTMn7oOwjYGG9rBPVylkXZUoJ9My9ozYrg1+s8Ipofpe5kUstZCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+s+FiRvl26AMlqx/feNN+g7mWF46Urr8/dHevO4uWM=;
 b=Lw/DVWuQndT6fOz8NQORHgY4mAw17gnWz9/gPljVKKN+MPm2RjB2uKV8aX0V6qfkhL7Tqr+pJ1+0cDdTCbZ176/7sW1MknkPwdr46dJ34n4y+79csUMXV4hE84v7NbvvDti2uZywMMYTfLdzdEEG8XqfSUBiY2+9u7LmxfKyNvjwzdqPZ/0oj+AaVHDWM+ZJCA/1pFKs6GGxeu04L7m6fotp/B3IjllTaRl/XaY0v1O2wUPuSzHwjevwrhNCDeiCCw7L3QnBgNMJwvqWOCPdq0DLbVpI4MPWg+ipEELCEEEd8U6LrxJ+WQ308zcCuziB/GFLvPar+capfWocUsK4AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+s+FiRvl26AMlqx/feNN+g7mWF46Urr8/dHevO4uWM=;
 b=CvThzLC9AGUPvmSy70uW84+UNtcC4YBp8YiiS7majc+Rzn88hHH0s+il5wdbNCB7zrThrIHW9nswNBSvGVJhTg/aK1U6bDDvHUnMbcX4eX0Nx8gus/r8Q90uQiiRe74otmfLZEWzvjEVQ5R5hHSsTzrQmawqdnT7IC8wknq1+hA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 23:21:51 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312%5]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 23:21:50 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
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
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>
Subject: Re: [PATCH v8 3/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Topic: [PATCH v8 3/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Index: AQHZhifwmS3nkBg8RUifIdaehLDgz69c0rwAgAAvrwCAAMucgIAAAvoAgABKNICAAQUugA==
Date:   Wed, 17 May 2023 23:21:50 +0000
Message-ID: <20230517232147.4ds4rvvexwzqbzdx@synopsys.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-4-quic_kriskura@quicinc.com>
 <ZGNy6FvVrBjYmorz@hovoldconsulting.com>
 <b2954b92-8b12-700a-af50-b914af7b0ace@quicinc.com>
 <cacc5813-404a-c2ef-e768-20f2acd696d9@quicinc.com>
 <20230517032124.rdh7ehnair3wjuvm@synopsys.com>
 <ZGSGc-X5Oir8wddK@hovoldconsulting.com>
In-Reply-To: <ZGSGc-X5Oir8wddK@hovoldconsulting.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN0PR12MB6080:EE_
x-ms-office365-filtering-correlation-id: 3a33db8a-4375-425e-caa6-08db572d7e47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SWIHAQZIunCK/ci8uQasV/WQy17jqnlXngnSPNiGtkM+yXz4RYW80LVps5wUfHvueUbcbDDrDhVFBXQUbUm/GG7YrqbXsghoVGkOACMYaSCjj5P+/NnbmhmCUQ51nf0mqjtFKtbF/dRdqC9E23dPGlSDor1/Rbzv05HbmM2KtTzV4RX6Zt08t64O29NQo0p2o117RaePU5zrTBYlkV8PnVZi6Pr5A+Vh8gEi1F7xsXI343orzqSDGrJFBAONLx0cTTImgT+2iOwmeQowx5CdYavtirnSRcK5q/s+/VYm0bBd4SBc4Bl2PrrOSNkUwv3yllQo1NPJO1DwywhVruJSSP90T8h7/Oc60ElnQZmfdPsNfN6P/93SlBmeCNgsTL9dQY6ATbiCSdNXsxwHEXNdEKaL6mIH8S+LoX77QuKU6xUiSn3XUe+V65r+Cr8iFfwxHb48jVp61aLRVU9zO6CJC0W3Yjnj8KB+/BPucoMcfDL17gs/HDwEumnMz1j9CWTGH6GKxHkN7UId3Uf06t0G/xLFxWLZ3PJjjlkgp3G3JK5bgqT+Nw0eLtbBwIUcBhK/NFHobyri8sx+rAFD+Lm4Dc60xneGUYIpdbwfMjx7LmYlvMvHfb7WUcKJJYN3z5QF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(5660300002)(71200400001)(41300700001)(83380400001)(2906002)(2616005)(38070700005)(36756003)(86362001)(122000001)(38100700002)(186003)(1076003)(26005)(6506007)(6512007)(8936002)(7416002)(8676002)(53546011)(66476007)(66946007)(66446008)(76116006)(66556008)(64756008)(6486002)(478600001)(6916009)(54906003)(316002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1liYkFMNGFUdHEwYUFlcUFCNWNoTUJSLytVdTF1T0JqajhTNnhHWkJlSTdj?=
 =?utf-8?B?TkJOSFpSanVQOXJXbmZIeWFxRWxXNUw0SHVSUnlmVmd5SnJrUTJWL2lkaEdK?=
 =?utf-8?B?Z1dQTm14TDlmb0h3c3ZFL0toZWhzM2hEOFk4Z25nSG5BQlZBTzdIOE4zakRF?=
 =?utf-8?B?bzdMV1haaC9aRGZvZlk4Z3QvYWN2NTRQclFMbGVPR2IyL1h1aHgrcWNsSzlS?=
 =?utf-8?B?Zk9PQml3WlZHVkRvUkQxUzg1N2hCZmovNXBnNzVzUzBLbGRtN3pKbHUwVlha?=
 =?utf-8?B?OUV1ME1XV2FkOU5VMUdBc3NUeDB1dzJzSmh6UmNGU1E0WHY5dFpWZkMraXlk?=
 =?utf-8?B?UnNrK2dBK3pnenovb3hYSTluemxadHNZdzJMSkpKYmFXSFV3MGkvQnRxWXJB?=
 =?utf-8?B?UVZNRkt4MXozaVMxa25ZWGFGR1B3dWZleGVvNFZSdE1VME01VUNzZmRiWUxY?=
 =?utf-8?B?cm5pYnFGbWJ4andRZHhyem5ZRGJEK1d0T2F1bEpsM0xjVXpTcm4xcnFRcGlN?=
 =?utf-8?B?aWNTcjZyWVZDN0NlVmlhcnZGNTRCU1hLL0poMWJpaDQxVXJPWWFaY2grOEVa?=
 =?utf-8?B?Tkp0cG5DcEVHcXBvQ0pBN1M0dnNRRjBUVERVcEdZb3ZvMHZENEpQY3dCU3RX?=
 =?utf-8?B?TGRZZEgrSFAvdFFHaVd0KzVBcDBaNGJuZUpabjczVURvZ1dIei9kcVlBcFE5?=
 =?utf-8?B?QjlVWUlKdUIybHFzUFFpelFLeldGVHhtQ3QycUlkaVY2Z3F4QStQYjd5Mkpw?=
 =?utf-8?B?azZQc1ZHVXFqVzJyZ05JZ1J6Uy9oaUZ3bXArVmNYVzRFc0dDTGF1ZWJtOHZJ?=
 =?utf-8?B?RDNKcVFWeVV6RUFUZElCcC84NnYxeXlwbi8wNFRjN2xQdWdFODJVMm5CZHd4?=
 =?utf-8?B?WXErcStDSHFJbzJDZ3RFcWFQN0FzNFVCSm4rSGtGeUN0TEpmbzZpMllOOUND?=
 =?utf-8?B?MHpiU3oxcXRyWkV5NG42Rk04UTFpTE9ZRXdLSG5GenA2SVRud294K1dZK1Nw?=
 =?utf-8?B?dDBQQ3psb08vQVJHNjliVERPTmF3T0RqV2w4N09NN2pFWXRMRVVYVy90cU1u?=
 =?utf-8?B?eG1uQzhVZVJDVXpZWGpSNGNBU3lkY2l5azFkaTdEQWovMHBnTDZOdkUxbUpw?=
 =?utf-8?B?WE1RQ0VOSmtEQjZXRXpaZlBycEtJYWxyWC92OUpQTEJBZEh2dHJiQjNvRG5a?=
 =?utf-8?B?WDJEaGk3MTM5V3czelRKTVVMOEpSYUpPNjlBQW5HTXVDd0c0Mmc4SUYwSTRL?=
 =?utf-8?B?T3YrQ0tsMG9BNGcvdVorclBBQ2JuTkk3MUFjYm9zQllpUDdFSjlVOU1Dclo4?=
 =?utf-8?B?bGVnOWdURVFDSUttbStqakREVm9lbU45Y3pnQVJJSjNsY0lOdTI3RXppUUE2?=
 =?utf-8?B?M0hLWUI1RVdMQmdndTJpNEJtUStkSkIxdHVpUmNsWW4zczY2T2V4cUlNdDJ4?=
 =?utf-8?B?V0hSV1VDOVY1MkZ6SVllVXhQR2EyZ2Y2L1BrNTdlbXpVMkRxQkFEeS9kc1RU?=
 =?utf-8?B?WmlLUEwxazZYV0x6M29MZGRJZnptVml4K0JscFdXT3BzZ0N4bXp5aWt1aDBa?=
 =?utf-8?B?WDZwRXVpVEx6cHp0Y1FKTUxhQVJNc3hWMGhQcy9MOVdZeUp5ZU56MXN1eU8v?=
 =?utf-8?B?YnRPRXBwS2RneTA1YzFTWHBoUDB3bE5zL1dCU2VVN29pNUJySGtZREtjZGJm?=
 =?utf-8?B?Q2hTZWJwM2ZRbGcwSDJmS0svWDVmZnpxeTZoeE1QdWVmcDVSYUYvclhhYzdK?=
 =?utf-8?B?dmFXZWVaZkFwSFNvREUzMm8zN1pwc201VER0YlZzOEJLNDJ2ZGI2MGxPUVZk?=
 =?utf-8?B?NHlJWDNpWWdPcUUxNXJvblN6SmZsZVp1UnNGUWZ6OE8vTlZHY2JhNjVSOHlQ?=
 =?utf-8?B?bVUzNzhTbGJBK1dUQy9MaENqVnh5dXRKUkhhTkpYc2lleEpLbjNJV0djYnhq?=
 =?utf-8?B?MG9RVUdCY1BnUjM5bDdra3p0Yy9BTVJFaFV6Y1BJS01hWUROR1lZeTh3MVBM?=
 =?utf-8?B?NkpxeExnZkZyVGdZM05YRndPejR1UE1zM21mWVJmUHhnN3BqTGx2ZVpFeFZB?=
 =?utf-8?B?NE45OWMyU1ZVSFA4MHhKNmI3NDVSa2U3aEN1cVVVanhPN0EvYXJrTVlsa0lz?=
 =?utf-8?Q?totYAEvXE8985T6s4RGfLL4/c?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A05A14EC532138438AD61128300459E8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RnA4NTFpTjQ3R1M1SWs2YmRKeTJDeEdkanR2Q2ZzdEFtOFRYdm5wUEFQT2dr?=
 =?utf-8?B?WkNHdGVIWDg2TmVkSDhqbGdhcTV2VkhGQng4QzBLOUFaaHNQaGJGTnFueGYr?=
 =?utf-8?B?V2JrUCt6ako4MDY4Y0YzMWJTUlh3THNyZzNSbDVuWXpaN1pZZzJNU3JCSXBW?=
 =?utf-8?B?RVBneS9RdTVUMkZjckhJeWJNdUVOaFI1cjFDdDArVnh4Ym43a1BYaDBVdkxa?=
 =?utf-8?B?cU96cXB4NzBnQ3ArdmpUR0p3TmIvZEdQUHNySmtiY0tOUVBrRDhKc1FvR3ZH?=
 =?utf-8?B?ZThmZityRlREWS9obnpwbW9VakdRQ0dDK2crNVRiTzcweW85OFBqNkc0ZHhL?=
 =?utf-8?B?N0JjTGZyeEx0YXhVeTdNTUJTcE51NmlDUFgrZ0Vldkc5Mk9XSlFheS9idjB1?=
 =?utf-8?B?ZG1JSUlUWEZvRVpxTVVLTXR4UlIvSGk4WHcvSW1IeTFYc2hJZloxenk5N1hI?=
 =?utf-8?B?TGwyL3J1cDZkOHplUGF6bVliL1Q5R3BvRGZZUVJKaEp2ejZqL3k2Ly9tOFpP?=
 =?utf-8?B?eGUyTllKSmRQMnhRVk1lVnFwN2FwcU9sdEVGN1BzbjZnMTNuYWk2bUEreWY3?=
 =?utf-8?B?ZTBMR1Q5cE1GaGVsNEY4ZGhHMnprNjR0K2w5dkY3aTFrTTg4dDlFQlgzaTBX?=
 =?utf-8?B?OEhydjlZdDJiby9pVGhxUmVVeHN2OVZqTXVKZWdLZWlST0dCYkxTR0NzWkdt?=
 =?utf-8?B?OUMvZ0pxb2xJbU9BTnBuNGdSSEgzY3NrUTFCWldzSHJ3OXlHT2F2cElkUzE2?=
 =?utf-8?B?TkRlekZ0UURYRGM2Q25VSyt3dWpnT1ZTTk0wU25PbmlZK2ZTTDZjZDRuR3Ev?=
 =?utf-8?B?VG1RdTlvd3Q2eEtpbkEramlWdDYyb3ZRcWh2b2luR1ZERU95V3RERzk1b1BP?=
 =?utf-8?B?endac3ZONHJDY21vYlUvelJHd3JyVmZkb05GQW43NDZpQWhwOUNJSFFRam9Z?=
 =?utf-8?B?dVlnb0tzU1ZUaXFmYXM3enJLS1ovQnEvTGJVUzVhbjl3ZVY4S2lRVnR0NmJt?=
 =?utf-8?B?RXFwYkxYeDhvcjlRSVZwNFVTenl5bFpSYWNDa3NKb3VxN1V0TmJxQ0tFWnFv?=
 =?utf-8?B?K3psVGdjZkJKTzZ6M0QvVVJKSnpRbE8vKzl4UG5mWXpXOTZSelVhbFhBem5j?=
 =?utf-8?B?M2plS2ZETVphUGJEMXUwd3gvOUYrYVhkdHFEbXlWdCtPRFoxNG5Xdm01dzhS?=
 =?utf-8?B?TElqTEZIYWh1SVV3dTVQRUtkUXk0ZS9VUGx6Q25aK0dqbGZPak5zYlN6eElp?=
 =?utf-8?B?NWlWb0MvVzVTRjUxUUZnT3cxaW42bDZxSXg3T3paMkRUK2cyM3B4TnUxNWJY?=
 =?utf-8?B?QWFVSXVXdzlhMDdDV3h2REpmYlZzZGI5UTZVUStSOW5VZ1lPalVKN2pTOG05?=
 =?utf-8?B?a2RFcWtOTzFpZEE9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a33db8a-4375-425e-caa6-08db572d7e47
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 23:21:50.6527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ugJAtXeakFWOVDBV+WhHjiyxEyInXQuu6NupXFOlUtjNgQHEe4GcJG2LqFExW9G0v6y4zuNunXH8tE5EoU30cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
X-Proofpoint-GUID: e7R1HwO1O2xUyQakz-Mda0yYYzJP2hj-
X-Proofpoint-ORIG-GUID: e7R1HwO1O2xUyQakz-Mda0yYYzJP2hj-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=809 malwarescore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305170191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMTcsIDIwMjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4gT24gV2VkLCBNYXkg
MTcsIDIwMjMgYXQgMDM6MjE6MjRBTSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9u
IFdlZCwgTWF5IDE3LCAyMDIzLCBLcmlzaG5hIEt1cmFwYXRpIFBTU05WIHdyb3RlOg0KPiA+ID4g
T24gNS8xNi8yMDIzIDg6MzIgUE0sIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+ID4g
PiA+IE9uIDUvMTYvMjAyMyA1OjQxIFBNLCBKb2hhbiBIb3ZvbGQgd3JvdGU6DQo+IA0KPiA+ID4g
PiA+IFlvdSBzaG91bGQgbm90IG1ha2UgYW5vdGhlciBjb3B5IG9mIHhoY2lfZmluZF9uZXh0X2V4
dF9jYXAoKSwgYnV0IHJhdGhlcg0KPiA+ID4gPiA+IHVzZSBpdCBkaXJlY3RseS4NCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBXZSBhbHJlYWR5IGhhdmUgZHJpdmVycyBvdXRzaWRlIG9mIHVzYi9ob3N0
IHVzaW5nIHRoaXMgZnVuY3Rpb24gc28gaXQNCj4gPiA+ID4gPiBzaG91bGQgYmUgZmluZSB0byBk
byB0aGUgc2FtZSBmb3Igbm93Og0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IMKgwqDCoMKgI2luY2x1
ZGUgIi4uL2hvc3QveGhjaS1leHQtY2Fwcy5oIg0KPiANCj4gPiA+ID4gIMKgIFRoaXMgd2FzIHRo
ZSBhcHByb2FjaCB3aGljaCB3ZSBmb2xsb3dlZCB3aGVuIHdlIGZpcnN0IGludHJvZHVjZWQgdGhl
DQo+ID4gPiA+IHBhdGNoIFsxXS4gQnV0IFRoaW5oIHN1Z2dlc3RlZCB0byBkdXBsaWNhdGUgY29k
ZSBzbyB0aGF0IHdlIGNhbiBhdm9pZA0KPiA+ID4gPiBhbnkgZGVwZW5kZW5jeSBvbiB4aGNpICh3
aGljaCBzZWVtcyB0byBiZSByaWdodCkuIFNvIHNpbmNlIGl0cyBqdXN0IG9uZQ0KPiA+ID4gPiBm
dW5jdGlvbiwgSSBkdXBsaWNhdGVkIGl0IGhlcmUuDQo+IA0KPiA+ID4gICBXb3VsZCBsaWtlIHRv
IGtub3cgeW91ciBvcGluaW9uIGhlcmUgb24gaG93IHRvIHByb2NlZWQgZnVydGhlci4NCj4gDQo+
ID4gUGxlYXNlIGtlZXAgdGhlbSBzZXBhcmF0ZWQuIFRoZSB4aGNpLWV4dC1jYXBzLmggaXMgZm9y
IHhoY2kgZHJpdmVyIG9ubHkuDQo+ID4gSXQncyBub3QgbWVhbnQgdG8gYmUgZXhwb3NlZCB0byBv
dGhlciBkcml2ZXJzLiBTYW1lIHdpdGggb3RoZXIgKi5oIGZpbGVzDQo+ID4gdW5kZXIgZHJpdmVy
cy91c2IvaG9zdC4NCj4gDQo+IEFzIEkgbWVudGlvbmVkIGVhcmxpZXIsIGl0IGlzIGFscmVhZHkg
dXNlZCBieSB0aGUgeGRiYyBlYXJseXByaW50aw0KPiBkcml2ZXIgd2hpY2ggbGl2ZXMgb3V0c2lk
ZSBvZiBkcml2ZXJzL3VzYi9ob3N0LCBldmVuIGlmIHN1Y2ggYSBkZWJ1Zw0KPiBkcml2ZXIgY291
bGQgYmUgY29uc2lkZXJlZCBhIHNwZWNpYWwgY2FzZS4NCj4gDQo+IElmIGl0IHR1cm5zIG91dCB0
aGF0IHRoZXJlJ3Mgbm8gd2F5IHRvIGF2b2lkIG1hcHBpbmcgdGhvc2UgcmVnaXN0ZXJzDQo+IGZy
b20gdGhlIHFjb20gZ2x1ZSBkcml2ZXIsIHRoZW4gSSB0aGluayBhdCBsZWFzdCB0aGUgcmVnaXN0
ZXIgZGVmaW5lcw0KPiBuZWVkIHRvIGJlIHByb3ZpZGVkIGluIGEgZ2xvYmFsIGhlYWRlciByYXRo
ZXIgdGhhbiBiZWluZyBjb3BpZWQNCj4gdmVyYmF0aW0uDQoNCkl0IHdvdWxkIGJlIGdvb2QgdG8g
cHJvcGVybHkgZGVmaW5lIHRoZSBnbG9iYWwgaGVhZGVyIHdpdGggY29tbW9uDQpvZmZzZXQvaW50
ZXJmYWNlIHRoYXQgY2FuIGJlIHB1YmxpYyBmb3Igb3RoZXIgZHJpdmVycy4NCg0KPiANCj4gQnV0
IGhvcGVmdWxseSB0aGF0IGNhbiBiZSBhdm9pZGVkIHRvbyBhcyB0aGUgeGhjaSBkcml2ZXIgYWxy
ZWFkeSBwYXJzZXMNCj4gdGhlc2UgcmVnaXN0ZXJzIGFuZCBzdG9yZXMgdGhlIHBvcnQgaW5mb3Jt
YXRpb24sIGV2ZW4gaWYgYWNjZXNzaW5nIHRoYXQNCj4gZGF0YSBtYXkgcmVxdWlyZSBhIGJpdCBt
b3JlIHdvcmsgY3VycmVudGx5Lg0KPiANCg0KTm90IG1hbnkgZHJpdmVycyBvdXRzaWRlIG9mIHho
Y2kgc2hvdWxkIGNhcmUgYWJvdXQgaXRzIHJlZ2lzdGVycyBleGNlcHQNCmZvciBzb21lIHNwZWNp
YWwgY2FzZXMuIEV2ZW4gZm9yIHRob3NlIHNwZWNpYWwgY2FzZXMsIG9ubHkgYSBzbWFsbA0Kc3Vi
c2V0IG9mIHhoY2kgcmVnaXN0ZXJzIGFyZSB1c2VkLiBTbyB3ZSBtYXkgbm90IG5lZWQgYSBnbG9i
YWwgaGVhZGVyDQpmb3IgdGhhdC4NCg0KV2hhdCB3ZSBtYXkgbmVlZCBpcyBhIGdsb2JhbCBoZWFk
ZXIgdGhhdCBob2xkcyBhbGwgdGhlIHhoY2kNCnF1aXJrcy9jb25maWdzIHdpdGggZGVmaW5lZCBp
bnRlcmZhY2UgZm9yIGRyaXZlcnMgb3V0c2lkZSBvZiB4aGNpIGNhbg0KdXNlIGFuZCBwYXNzIHRo
b3NlIGNvbmZpZ3MgdG8geGhjaSAoc3VjaCBhcyBmcm9tIGR3YzMpLiBUaGlzIHJlcXVpcmVzDQpz
b21lIHdvcmsuDQoNClRoYW5rcywNClRoaW5o
