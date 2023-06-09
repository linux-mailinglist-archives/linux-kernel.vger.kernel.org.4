Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78971728C7F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 02:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbjFIAdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 20:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFIAdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:33:40 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E85E2697;
        Thu,  8 Jun 2023 17:33:39 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358I0iLu027414;
        Thu, 8 Jun 2023 17:33:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=8qsLQUug5hlaQjal5hq3gVNWzDc2mN+EyEKc0WuTY9I=;
 b=ZtMz7ZCJ+MWnXA2F+dXGU0e4/OyaNJWlKjVyciha1+Gp3fNY+a8ffJRztDPM/PlihQmb
 QSKPEFo7+SDdusLVHdZ6Gz0H3nbIYX9Mjg0JxV7sVC2k3AOrgpUA6xlLKRpHqEczGF+K
 EAmzwVUcm4p5FDq1dnWcr7rjzTvZWU0K032ZXayhKBz1oSyQJu313q5B2mTW4hFoTmUI
 Vo1iv0KYCLhDcbyGhUHmpusLyz7YA9ubtrEhfndLwH7K7KKBxhREL6OyAkNteDlOObtz
 QwmAVlTGk/FI8XoQeHiA9edxW7zXYgHsuIUtpFgOu1VN4MSPuirlPH5alrU1VMf1CNPG Hg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3r2a6xcme8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 17:33:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1686270807; bh=8qsLQUug5hlaQjal5hq3gVNWzDc2mN+EyEKc0WuTY9I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KovhxPofoVAuUV85rgcMbxMgkomwOfMiCLFS5McD2SJhhdWEnpfVi57V5/Gg2jF1u
         mtG7TdcJ1ckSSnxpShf1jlxwV/y9ZRjkvr4Enp0GXNgUIDopUd8bK1Smo+3keCi979
         zFqKfKKNUU6e+IdAw7rLJuBcjJqXdTmmrQLIuGRZB1Fmx9GH+36qcSCIWzLaJ+unSh
         itgzMrFvIbM18r5PoXXm+YyjtuMJBc0BsObSo8zX+ChXkMRZCgBzUHQtfryXD8IpPl
         bEmbCUg3UkXm+Rkr5y+6nnxZoq+O8FCw5j52OpAlJMnqtj/5EMCBp6uKaIQM2o4jer
         h5/osA7kyj7pg==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 48FB84013C;
        Fri,  9 Jun 2023 00:33:26 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8240AA0071;
        Fri,  9 Jun 2023 00:33:24 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=WMCgED4Z;
        dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 217224011F;
        Fri,  9 Jun 2023 00:33:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCGl758zo5ibdU7Oht5I0WGKipKYc1KcYMRgxUTXqyWA2sqWbfDsN5JoPZciNi4NWjGHmxw37lHV0ZkcfUxH7DnaQp70tEHJs87h+bQaYpiW56wx4iNScvagWy5ozN6TQlZ5tJ7tdaryTj5izT8Wasl87TtLFgIMoiLlJfLBSXTIwAZQTUMUc3hylzO920E2kumb2wNyQd3aWCgwrogKvVJgLoFt54FZWBNoQv0ia72ZNse92mRdLe4q+sY0K+vMXfOQrqGc3ldVIw8sSqFLA1RQpsSa3hk8wlxPeaL3QjyI148lWzrTcD3zWXAp7KhlOwx3v+MJ5At060IdzwCrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qsLQUug5hlaQjal5hq3gVNWzDc2mN+EyEKc0WuTY9I=;
 b=Qt4A3AZw+oV4LNj4KF+K9zmZqc3fC/YhK80Yl/3o40/7pRsBGle8tuhp+R0Xn5864VpoBSOMYf5/LbEaM+r1iaoJB/MSFiY4yK2gkQ1SkN21cbxeZrpEALm7gh/3IRbGMDaXjh5kpmbm+pxv95fj7r7GLlsPG9kzJjaC7THfoq7ty6U/RCiqXhd456CO9jLb8wyaj5PlUWcWbVC8oLcIDC2Vz8F6MG1zs2mtCeu3m03CGXLd9cx5+ji8nDOtKr/zIwsgf4NJs1Aob69faeNo78IDyPs3acCsPC2VWIDwoODyQQ5Uqx4vQvCbrKPZTMwPQAjit2aknEzKfv59CvcxJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qsLQUug5hlaQjal5hq3gVNWzDc2mN+EyEKc0WuTY9I=;
 b=WMCgED4Z6q3OgSA1+zQMtCi0JRGU7v72hqd3RCdZZE3GdxF02ay99CWsnqUO3k1ir7VClvlhnWN0wBXnr4i57WVDE802tWoaoyiccOcjwYGpwNgYERihK2TZk/qBXO2C3aMlkfYxumBt6RQJ/dpNYJLkDMEix0GBg2Y29Xc7zCU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Fri, 9 Jun
 2023 00:33:20 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b%3]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 00:33:20 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Johan Hovold <johan+linaro@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Li Jun <jun.li@nxp.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: Re: [PATCH 2/2] USB: dwc3: fix use-after-free on core driver unbind
Thread-Topic: [PATCH 2/2] USB: dwc3: fix use-after-free on core driver unbind
Thread-Index: AQHZmTGZuQzT3F/wQk63hqBc2fvZMa+BoZSA
Date:   Fri, 9 Jun 2023 00:33:20 +0000
Message-ID: <20230609003317.3lc47qn5x3oe7ju5@synopsys.com>
References: <20230607100540.31045-1-johan+linaro@kernel.org>
 <20230607100540.31045-3-johan+linaro@kernel.org>
In-Reply-To: <20230607100540.31045-3-johan+linaro@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MW4PR12MB6976:EE_
x-ms-office365-filtering-correlation-id: 3f52bdb6-da48-4f19-2a1d-08db6881205f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DRXPweQ5IdJMvAiEApYA8fnytNZAqPgqyuJoLYV5MkUe6gLo4jOEs0ZJPKbhcQYAUIIT0SaPWLVWeMDBtswIpTlGs1yQLxOD5lbGD847gfY0iWWIAn+ltyjEM++4STb0MZv1YsXjuLP5LRn/3MniddYWJ17Ifuh0zuc0LxRD6eUT4Noyc8N13Vb1Y5mjDwkc4CzC+R7rGQatBZBkIBNngl9i1YO0DDcr2MsP3/qJKE5ORLofreEQCz+CAKOrh8C4URFhj2FpHjezOgJyDSBLreTPfy6CqgFwrmD2Q07hulsw7I4e/Xjkqr+pMz45dMMhpEN8NPstoWMUkg2C3dYu8/McAoRyQ/oT35I7SjNdmGbknfTPNNSgmzVsWWbHRm9F0JRzzzKp3MZ9FMCRmJNn2t1S7U0NuQQBm8ZOrZePcr2oak7sSsOXJx12o2gSPqFQ7RHMFZMsppAYuWMoCdvcxdjn/QSwbMWPiha1O73zg4YagD+pkj7rXr2dkZjbqjCFZfDkPU0hRnXupWive+sBYFLTpn7MYm4LwNvPWbtjsWfepdiaEEt4nUTxj1x8gLEwotP123RRwkBzf0+00iCT1w6ZQRc3SsbMzuguX1PYgvsGw9oGYnvCRGwkszPCAj4N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199021)(54906003)(122000001)(478600001)(8936002)(4326008)(38100700002)(76116006)(66946007)(66556008)(66446008)(316002)(66476007)(64756008)(41300700001)(2616005)(8676002)(186003)(71200400001)(6486002)(83380400001)(6512007)(6506007)(1076003)(26005)(7416002)(5660300002)(86362001)(38070700005)(2906002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFd3TDBLOHRCa1BKRzFzUlZXUGxwSVVRYXpXUVp5T3RPaTZCNFdOZTNSRWMx?=
 =?utf-8?B?QkpXVi8xOGxwQ3U3eHhtMW1rQ01BdXBjaUpTK0JXK0xzSHlyd0l6SHhTTnEw?=
 =?utf-8?B?c1k0Y0FtN2xiZVc2clczTFlFblNadlVYL3BGOUVnOExZMTNJWFhpNXhoT3BN?=
 =?utf-8?B?N3dLODVadHAxRG5lZEdIc1R2UHc4QVh0V2RVWngyRjJZWklzVEFWNTJTL0pO?=
 =?utf-8?B?QURoZy8vb21GazRaRXJBKzNwRVQ5ZHRoRU5KMmJ2cGlpanBydXNaV0Z3YmJY?=
 =?utf-8?B?a1NQanlqSDVwMXpTTzhDTVdmN2JHNXRIQ1QxQ2VWaW51TmM3SEVZNXllTUdM?=
 =?utf-8?B?c015aFJmelFQTVVPd21Ud1J6ckhOYWVLYW80VVhrcHFLK1YwN3NpM2VQMm10?=
 =?utf-8?B?WVRMNkxwT2hXaHU5dW1zUTV1RUdyMEI5b2tXcHYwUk00QzhuVlg0NUFCS2dv?=
 =?utf-8?B?aHJGNXdEcVBpY1hRaVhFV2wyRHNoT0xyRDVuZUsvVUl1VytlbzV1TjE4M1FZ?=
 =?utf-8?B?VTdKSFdpQ1J3b0psQVZMdzE4dGhjSzlyMFFqY1RLOVB0Z1R1anNQQmdDSC9L?=
 =?utf-8?B?aWVpSFl1MktUM3I3dDNHYStlN3JqbWtubWtSQ2doczVqOFc0eDlqZ3dKam84?=
 =?utf-8?B?MWJqb2R1dlhFNSttL3VrUmRJbVJGM2ZzZnZGU1dQdUNFV3FLei9XUmtpMDRP?=
 =?utf-8?B?a0hqdTg5Z0w1NUJFSGVoL2dna2dqNysrblE0T0RpS1Z4d1ZKZXByUWJ0SjBB?=
 =?utf-8?B?V0VqSHF6L1lMTUF1SzdydnU3K1BtZzZwL2JJNGZWZmhFWHhiRTAzUGI5MmRn?=
 =?utf-8?B?UVd2MitpV3diczRyVks4Um0zRXRwWk1pVWZLVlVvZkx0T1lzQ1Z5YnlxSTZT?=
 =?utf-8?B?a3BkRFM5M3NCVWZ3M0c3M3Rqa3RlVHZsZTkzTm5oR1JGUk5pRkVvVElLaUJn?=
 =?utf-8?B?enBxQWdXdUxCL2FsZUYzdHpnSUpEaGR0dElxb2htbmlmL1VmV1h3MDdCUGtU?=
 =?utf-8?B?QmszcWVWZzZMNWtNSzN1Vm9iMVRqMnRWbTJpNEwwL3EzNGtCU0xTTmhHb1pn?=
 =?utf-8?B?dkJGMVMrUDNaYTlQVk9FQkw5SDNjbmx4OXdwa2FsZXpMQWdJanpFU1liRXYv?=
 =?utf-8?B?MExwR0pUZHp6SEdyN24wa0dGU2ZDZlREYVpqeXU5bEk1WjVJVG43VjU4TUt3?=
 =?utf-8?B?YUhhTkdsbnlNQ01ybXh1Z3AxT3RZalZ5T1dGbEIrZys1TllQekovMnVyKzJF?=
 =?utf-8?B?T1cyYnBTeVhueHlhWUxSeE1kTWVvZDl0NjNKN21jcHZocUtrRlpTWXNwc1Ft?=
 =?utf-8?B?R25zd1BRYnZ4ZHliaXVVZDJNaG0ycGJGQWM0UEZSTzFXQk0rT2thNnhWZFVS?=
 =?utf-8?B?ZVZnOVMrS1htSEJnS29iY0d5UVpvNGFrbDU3ZFB0SmloQ0ZnRFNqZllHNHNT?=
 =?utf-8?B?T3A4ZmI0NEZwR2JRTmNKaDF1d0hyekNhQ2VuNk9XZTJQaVBEeUJhNkRETnBW?=
 =?utf-8?B?VTJhdTBCV0dJUktaOUpndlhYZU9YMFhwYXkyaVozMFY2bGd4WHprWG5HSXdD?=
 =?utf-8?B?UHN1UjVNczB2WVAvUDZRamRqQTUzaDg4VVZ3dysyRS9VOGlhRjYyeUhHM25s?=
 =?utf-8?B?QWZkQWNNMDNSWndLY3hyYU5CYVlad2gwZXplVStLeDNETk1wQS9KK29ETHlX?=
 =?utf-8?B?SThNbEhUZ2pHa08ydHhwMk5lSHBRVGdVMUMzT1kwa0JpTHNSU0Z0NkhOOU9a?=
 =?utf-8?B?V0RzY1g2T0tmQlg5SVpPdEJzeUgzR3lzMjM0ZnBwb1VtTWgvcldmaWtGY214?=
 =?utf-8?B?WWpMZFM2TFRHR01nL1BxVGx5RGduTG9wcFk1OWJyaHFWTnF6U0xxZmxpYUxT?=
 =?utf-8?B?NmNoK1NpNjlVNnloSzgxTVlzTVRQUURad2RpTXRDQWhlMzRuWTlDSk81dFRj?=
 =?utf-8?B?RFFlTyt0NW5sSlJGRVZmMlEzVXdCS3dPSFFsQTA3YjlOK1BZV1YyRnZ1QWM5?=
 =?utf-8?B?M3VOS096aFk1WWhIbm9VdDdFdU5vZTNYaWd5Q3VDOW9nUEtvT0lhOGpYa0hQ?=
 =?utf-8?B?Q0VOLzNqR3BmVTJoVlU3YlBMNjJ0a1lic25zRlNvUkMraTdrb1NITWFQZUJp?=
 =?utf-8?Q?E36227PHjPbVs0P9wj4IAAoVz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A75E5B86C946441B8BFC0EFC362605C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZXRwZUdQRlNKSC9rekZSWkFLczh1MWpkRDdjMGNPV3c4TEVUNWRIZTRmUG9H?=
 =?utf-8?B?L0NnR3hnVTdwMWtpUkx0cHA5ZXRsaWxpM3hSazNvRkdhc3Vkb3FEdmlpSytI?=
 =?utf-8?B?MnkyNnR1WWVaekttVWdlMWwrMk42ZW1WYVN4ck8vVVkvcTdQSVlYdzhJWFor?=
 =?utf-8?B?VC9COUtwOEFCaDdMSkV3K1dpUElOY0RBMlBiN2Vtd2pCNFdNNnBod2tQM3I4?=
 =?utf-8?B?M29SaG9vZXRoY2N3SzdlNnRMWVRtaWV0L3ViNGh6L0s1MUdDZzgxbnhsUE1r?=
 =?utf-8?B?TFZ5dDF3WXRPN0JFTjFUT05BMWFRV1RSZzRFcW9nS1RuUjFzMXpYMWx4YnBV?=
 =?utf-8?B?TkhvRnBnU0NIT3hNSXZZNmo1bkJBck1POHNsdE0yM0MvNnZPL1dqdjZ4ZVRQ?=
 =?utf-8?B?WWozbXlvWVpYY0Zvamc2ZWd3TWZwU2Z0SzZ6blVkK3NFSDB3eHhPSWZZTStu?=
 =?utf-8?B?YVZmRnlXSFNuSGxxdnhkejJzbDk4c2p2cVJ5K1dkT2VlK2VXS3ROeWhsUnFk?=
 =?utf-8?B?ZzA4Q3BoNG9MbVRVU1hGSUQzaFczZ1M0UDd0UldadVNlc3kwWHF3NXNIYWdo?=
 =?utf-8?B?N0RwOEQyOEVodmtYdUw3RHFVcC8wa0V5Tm5tV1pvMHRWQWdjTm1tajlEaGdZ?=
 =?utf-8?B?OU9FZUxseFJIYmRGR0k4ZzV5Tm8zdkhyWVcwdlZya3pVS0lvRUFzaXJlMFE4?=
 =?utf-8?B?ai9MQ2FUNU1iTVdrMElOeUFJT0JDcFh0UVh3SSt2MXVEdFhNR1Q2bUdlMkt4?=
 =?utf-8?B?SHhsNnB3WFY4TjRINEJqRHNhalhTZjlCMUNYSE55UFBBNkhVL0NqM3JaL2gz?=
 =?utf-8?B?WHprQ1ptS0Y3OUczMFlNVzNNUkNXT2VlWU1ETjZlNTcvOFBjczlxd3lGVjlY?=
 =?utf-8?B?Y3RTN1p2Zm54ck5iOXJkbjMzYTVPb1pjVEJYaEpReFFEcklucVk1NUIvTG5j?=
 =?utf-8?B?YTdIQmRENW00c1cyeHdkWjdQaDZjS2F4ZTVXQ21xV0FpRVN5bmIxU0x6c3hh?=
 =?utf-8?B?ZVNwTm9sRUNrZjlkQXc0WmhwY1VLTFRqdmEwZjM2VXloQ0Jab2Uya2lCbUhJ?=
 =?utf-8?B?RkNDVzZzTCtZemJScG84dWkyeEMzRmRYSHlMd3o3b1Jqamk2M21SQ0t1RGJq?=
 =?utf-8?B?MGsvSFdhb1VFK21XZGZHZXhJTldNSi9pb0MvZFhPRkJodGM4aG1Xb3M2WTY2?=
 =?utf-8?B?SnNWSElJU0hQTGRjRURKMUY3UnF1Z1RQMm56NFM3ZEgxL09MOXlLbFlFdXR4?=
 =?utf-8?B?ZUFaZS9jUlhVbjFOSU9rSGJJNERXWjdhZk9GQSt3Q1VRYzZSZz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f52bdb6-da48-4f19-2a1d-08db6881205f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 00:33:20.5634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nt3habNYaOvXNFG73LpmT+crimPgJhKemWMPB8ISX/XtSaSOq8eGgRXlpcui3/UqtNfyhFnSnE5mLqyluASbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
X-Proofpoint-GUID: Vh7qhsZGroG547rE3HbJiOqVR9pblr87
X-Proofpoint-ORIG-GUID: Vh7qhsZGroG547rE3HbJiOqVR9pblr87
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_18,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 suspectscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 mlxlogscore=627 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306090003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdW4gMDcsIDIwMjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4gU29tZSBkd2MzIGds
dWUgZHJpdmVycyBhcmUgY3VycmVudGx5IGFjY2Vzc2luZyB0aGUgZHJpdmVyIGRhdGEgb2YgdGhl
DQo+IGNoaWxkIGNvcmUgZGV2aWNlIGRpcmVjdGx5LCB3aGljaCBpcyBjbGVhcmx5IGEgYmFkIGlk
ZWEgYXMgdGhlIGNoaWxkIG1heQ0KPiBub3QgaGF2ZSBwcm9iZWQgeWV0IG9yIG1heSBoYXZlIGJl
ZW4gdW5ib3VuZCBmcm9tIGl0cyBkcml2ZXIuDQo+IA0KPiBBcyBhIHdvcmthcm91bmQgdW50aWwg
dGhlIGdsdWUgZHJpdmVycyBoYXZlIGJlZW4gZml4ZWQsIGNsZWFyIHRoZSBkcml2ZXINCj4gZGF0
YSBwb2ludGVyIGJlZm9yZSBhbGxvd2luZyB0aGUgZ2x1ZSBwYXJlbnQgZGV2aWNlIHRvIHJ1bnRp
bWUgc3VzcGVuZA0KPiB0byBwcmV2ZW50IGl0cyBkcml2ZXIgZnJvbSBhY2Nlc3NpbmcgZGF0YSB0
aGF0IGhhcyBiZWVuIGZyZWVkIGR1cmluZw0KPiB1bmJpbmQuDQo+IA0KPiBGaXhlczogNmRkMjU2
NTk4OWI0ICgidXNiOiBkd2MzOiBhZGQgaW14OG1wIGR3YzMgZ2x1ZSBsYXllciBkcml2ZXIiKQ0K
PiBGaXhlczogNjg5NWVhNTVjMzg1ICgidXNiOiBkd2MzOiBxY29tOiBDb25maWd1cmUgd2FrZXVw
IGludGVycnVwdHMgZHVyaW5nIHN1c3BlbmQiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
ZyAgICAgICMgNS4xMg0KPiBDYzogTGkgSnVuIDxqdW4ubGlAbnhwLmNvbT4NCj4gQ2M6IFNhbmRl
ZXAgTWFoZXN3YXJhbSA8cXVpY19jX3Nhbm1AcXVpY2luYy5jb20+DQo+IENjOiBLcmlzaG5hIEt1
cmFwYXRpIDxxdWljX2tyaXNrdXJhQHF1aWNpbmMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hh
biBIb3ZvbGQgPGpvaGFuK2xpbmFyb0BrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNi
L2R3YzMvY29yZS5jIHwgNSArKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXggN2IyY2UwMTNjYzViLi5kNjg5NThlMTUxYTcgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5jDQo+IEBAIC0xOTI5LDYgKzE5MjksMTEgQEAgc3RhdGljIGludCBkd2MzX3JlbW92
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXBtX3J1bnRpbWVfZGlzYWJsZSgm
cGRldi0+ZGV2KTsNCj4gIAlwbV9ydW50aW1lX2RvbnRfdXNlX2F1dG9zdXNwZW5kKCZwZGV2LT5k
ZXYpOw0KPiAgCXBtX3J1bnRpbWVfcHV0X25vaWRsZSgmcGRldi0+ZGV2KTsNCj4gKwkvKg0KPiAr
CSAqIEhBQ0s6IENsZWFyIHRoZSBkcml2ZXIgZGF0YSwgd2hpY2ggaXMgY3VycmVudGx5IGFjY2Vz
c2VkIGJ5IHBhcmVudA0KPiArCSAqIGdsdWUgZHJpdmVycywgYmVmb3JlIGFsbG93aW5nIHRoZSBw
YXJlbnQgdG8gc3VzcGVuZC4NCj4gKwkgKi8NCj4gKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2
LCBOVUxMKTsNCj4gIAlwbV9ydW50aW1lX3NldF9zdXNwZW5kZWQoJnBkZXYtPmRldik7DQo+ICAN
Cj4gIAlkd2MzX2ZyZWVfZXZlbnRfYnVmZmVycyhkd2MpOw0KPiAtLSANCj4gMi4zOS4zDQo+IA0K
DQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpU
aGFua3MsDQpUaGluaA==
