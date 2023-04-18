Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE656E585D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 07:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjDRFGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 01:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDRFGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 01:06:36 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D20C3C0D;
        Mon, 17 Apr 2023 22:06:30 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I2f6Pt001506;
        Mon, 17 Apr 2023 22:06:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Lp8vgSaj4yuztHrE49o4Ev+jDSwAH7U7rQYCMrSIQKU=;
 b=Aq4hmVpvzt00MzH5YmiaU2e9qpCx2EdQqkWUA80vsNluFcrCrlZHgBkUw5Z+Aj2fjDAH
 84pUy0oRP+4oT730ocdlGh3yFPgO5X3M1VcEC+4MSu8F2ExYbSEixoAzy1B6WPHV2E7x
 QGm5ofozhdpfllluQxm9HIXjiDkV/n5cKNBnITSO6W0sSWlzei5jipuM7rT4qSksnJwa
 dD1tEzkT/3NzJGd6X1da+s+pGt57YZi6qdwKFQXEkqmGuPKniP9Wm3Mk1YEJ3ctSLXvY
 DvFlqfa+jwQe2Va7GLhLGJ6blZLWNABoLwx5DZJTUhWbvk2wtrc8q00/n9d/LppvfLSI Rw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pytuvjgg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 22:06:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1681794375; bh=Lp8vgSaj4yuztHrE49o4Ev+jDSwAH7U7rQYCMrSIQKU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=dcYTHqETfkPm0PfeUlLSdz9gWJptYRXPPVTLMd2yAQiaTtxXvYIkTE6muZoUnr71L
         AmexZ012cjAmOnES8ltZa6OMjx2hCGurobjXa4ZZUlbULSKHn1KHCo+u+BVmfSM+ZL
         SPWsz6daFxK82KWZQUhiwvC3hZnWmwfZ6Chze0Q5CVKrPlYdrLXuxROTgS5hXVBsns
         nTdI82yYLfChiWSXzzh2ki1Yzk2n/A09x/z40eKlj/+adRhxQ4+YWFctJd1j0KAYce
         mYkT0iamheVPaJAQuj1+l5SV65YKRQjy/nFO7+WAx02CEmXapLSRKUF3mY23sCGuCt
         vkzVwMLkSSoSg==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7267640A4F;
        Tue, 18 Apr 2023 05:06:15 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id DFFCFA0062;
        Tue, 18 Apr 2023 05:06:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=vH59tnFT;
        dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6C41B40DF0;
        Tue, 18 Apr 2023 05:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBm5PvUPXBnOFcse+z6JtEdXso57TEnQVtHA1EDy1OufPcKMkeQNWXNMcySnFwUH21jDQ2UcHUwJKSp1N54bsHSH3CjDUIwv3NGGhAY/EbshnJOEMo8TPt6cJ2NM8KvlzbHFywmLN8/cnrKeoHdS1EULfR1edUkArJmv0x2IhGxIjFzvGuCq6MdFQFBGjKdnf468zXWkuHQCv4BQG33yMDaRyurGSnniJOZAfZKrouvszOvWBdlEuLVM1J6A1u0ch3pVLkR12Yo8hs24IYNknfwkhB66Cw+fmEjWRnWJU0zr5dnqlQWfM5jCBBie9ZCJ4HXZumyp1XGgw8NkRZ0Usg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lp8vgSaj4yuztHrE49o4Ev+jDSwAH7U7rQYCMrSIQKU=;
 b=R3SYz498+TxfTuNJr+CU2ZcDRN4rZBOQpyA82xyKYjEEy3OgCmdt34VTxJzRTxRaDWknSnxnWrc3UDN/C8GDWV1UPsWra4rtu131KVj3eb0bRU5dK0WaIBzsqJLOJHfwwB37AuJ4/HeGimN/iUEeieQd9a1hSNdn5wHE6fsd3PUg8N0ObLJ6K303KFl8sVablIiHIg8iR57UZEfIUYhB+57shlNOzc9q0xmog/yFIK89zMIb8jZ6f7mc6h1OlTQOhOK4UozoKxRobDQyBYrOBW2Ctr8xfB23vWxcH7q3ka+BQHPk58SpuWszxo0NVB/xll95QG2megoxTMFC8T755A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lp8vgSaj4yuztHrE49o4Ev+jDSwAH7U7rQYCMrSIQKU=;
 b=vH59tnFTpYn4Qsn8tLAT5z1h7eXHdz5mErI+eOuEQuZBj5JD2EtRsp2yOUr4t2fcJnYiauFUEuGOAezZptSfmyA20AmstV2w1nuEQSiCGOviRszYRcl4G3b3CzHqah+4X3LnKD9gwsj0dOKyRMhiu9401WdYGS4IOBZfpWv6OUM=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 05:06:10 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::2dd9:84:a1cb:ece1]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::2dd9:84:a1cb:ece1%4]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 05:06:10 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "amelie.delaunay@foss.st.com" <amelie.delaunay@foss.st.com>
Subject: Re: [PATCH v2 3/4] usb: dwc2: platform: add support for utmi optional
 clock
Thread-Topic: [PATCH v2 3/4] usb: dwc2: platform: add support for utmi
 optional clock
Thread-Index: AQHZbq0bUf3r8fJ3QEidDuDILR/yVq8wiZ+A
Date:   Tue, 18 Apr 2023 05:06:10 +0000
Message-ID: <f4535830-a840-f1b6-81da-76108f08a3aa@synopsys.com>
References: <20230414084137.1050487-1-fabrice.gasnier@foss.st.com>
 <20230414084137.1050487-4-fabrice.gasnier@foss.st.com>
In-Reply-To: <20230414084137.1050487-4-fabrice.gasnier@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3399:EE_|SA0PR12MB4479:EE_
x-ms-office365-filtering-correlation-id: 248bb434-990f-4fb9-e1ab-08db3fcaa011
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vjelPsXcImprVRQg7eyhNziQ4ufvf0/lijSdurIKkt9/PevFFnst5CUkU5Bv0dIZZe40GUaxjABtlLWySy99b5brMrrtTkXsHtlaNuNUq5raYF9z/nqYxO7H5vv9nqX68GakCnJ7o57aWWxnEVcXvyQVRH4nUOfBDDTVPaYCVrvRZ2/GZ5X1ptAcIhr9hKLdhId1ORAPTRWSYG6YBRs5CG7ox+g2+YvnAm+37tUreGAYBFdE0P2GIc3mTGCHCNHmhzrqoROcFzbMGGJ0WTUOZQZWyE8rfcPlrE7ofX6b++J5gWuKNXqAT1ZH2s8lraV1PnqJQUGVJvd61+PyS4BwSog8EZtU1Yh/ENgATpTgD3EbGEwpL2ZloL4mVnGD3DAGQQUdCz8B/mqsomHPTkcopqO5UEDdjoqllu44Euf+eBiyixXu1jl8uOx/+UnmxOUJnH9hWHC32LHnUNqBinvIBHjZgB+j9r9juKX+DINQ0BZCKM0ZQ6jRblhmUhz/UxLgIqWG+41EqcZRnVydBK8LHShsbJKffITKlYey5g0V4ZoofwdesYvY798Zdl4wjM/UduOCFO5TD4LHZmXPHGSz93r0p5eQ/BnIVO/6R/VQFgqWVMvN6RbK1wUk+9DP71TLWXiRdl9yAHR8hdRwUYMnmFqKL5BnD4MMJL1dOuKHyLAHOvU9/1dQijJ7hhH1mgfX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(7416002)(5660300002)(2616005)(31696002)(83380400001)(122000001)(86362001)(186003)(26005)(6512007)(53546011)(6506007)(38100700002)(38070700005)(8936002)(8676002)(110136005)(54906003)(478600001)(71200400001)(6486002)(41300700001)(316002)(91956017)(36756003)(76116006)(66556008)(64756008)(66476007)(4326008)(66946007)(31686004)(66446008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWl1RnM0S0JxeDlnbnRjU1RTN3JjZ0FYeldKbHBGTm5uZml6UnNBeHRubVp2?=
 =?utf-8?B?YWZaOFNrekpyNnBlbGduYVJJMWk5a1c2OFNCcTBUR1U3NnVpR05YYUVXVVVP?=
 =?utf-8?B?cVpSb0hHTmM0eHlka05EY09iNFdqZENIWFJRWmF3ejZsNEU4L24rVHFVVjJi?=
 =?utf-8?B?VU5SNEExUUdhWU9BYW05ZWhzVGVHcEN6eXlOdWJnaDFyRHZxWmxlQmRCa1U4?=
 =?utf-8?B?NWlObFF0a2h2eXV5Y09haXREL2IwRXBKWi9vMzFBR1d3dlVlNldZT3dwbUM4?=
 =?utf-8?B?UlRzY0ZhUUgzQzRPeml0RUdIWXF3eUNPMUV0QUtyT3l0Rks3WFFaQ0dCeDZn?=
 =?utf-8?B?YVo2K2hGZHVCOXBXOVJQd2lRSjloL1E4elNEK05NSFp4T05CeUVhajgwSTVj?=
 =?utf-8?B?OHV5WU9zek9oVnJob3BlSTV5d2xpdjZVMXJtWkNDK01lQkNLbWFHZXNJREtJ?=
 =?utf-8?B?UmJOOVhoam5KZW1MRGhpUzR6czc2RWNWckxMRWFacXVWOVFOK1BKN0hQRG5u?=
 =?utf-8?B?NUlYc1Myd3pnbzBVN0ZLTFFsUkdyQzJYOVFBYW80MnFncUlmSkRwT1RqVW1J?=
 =?utf-8?B?aDY2ZnhTbzgvK0VySUNQejNLWDJDR203TUM3c2JUUFhlQzBQYmFHb09Lc0Zl?=
 =?utf-8?B?ZDE5VDFFTE5YTDFPcEY1VkQzRnk4SDljQ2tjYmtXaEsyVU1EWEp4TWxQbWYr?=
 =?utf-8?B?YW9Gcks4TjV2ekhKczNsdTBHeXhmcHFoL0ZpSWJxZnUzck0relJHckxQZ2Zh?=
 =?utf-8?B?ek5sNnp0V2xibE1hRGx0UENNVWJmV204ZHdDMzJ0bzE1MWg2TCticU5mVTdI?=
 =?utf-8?B?Mm5Dem9Ia3JBazdFcnZzb3VaNU8wN3RtT09Yb3JLKzZOMG91ZHdXY1I5dWly?=
 =?utf-8?B?bGVYYUUxUlV3WEMyNHV2SEM2WFVvSXhzSHRXZmcvVk45Wmdqb0luRUdLbkVC?=
 =?utf-8?B?SlB3Y0hLNmo0WGZJV1FZMGNGV2JjSUt3Z0dNRUEzMWJISFRzdTBZVS9WM29q?=
 =?utf-8?B?UFYxbHB2MVYyRlQ1SHplckliWDhLZ0dOTkE3NXlGQTdVN3ZueWVUanJBSTJB?=
 =?utf-8?B?VUozSzF1N0draEx5VzZTUmtJSnhVNFIyNysrTnVJeGpMTjVQWW9vSjlocFM5?=
 =?utf-8?B?S0pxb3Yzbkp3VmYzSkp2WGI3NnZGbklQTjNSRURBYnVOejhKZ1dtS3NFbEYw?=
 =?utf-8?B?Vjl1UU1VR1NMRGM3MEZ5N0Z2SXdDWUowMU1odGZTRUF0K0FsS0FTdnkxOGFz?=
 =?utf-8?B?NDRDQnJhWjBqMEZCb0d6UFB1WlB0OW93R2pYQXcxNGtVRy9IMmhGVjR2cU5M?=
 =?utf-8?B?VjVGU0ZaaDFnTW55RFEwVUZwamNZVjAySE52MkVkT2RzcW1aYjRYbnhoRVJG?=
 =?utf-8?B?NkpXdVY2VmZ4ejhJR3habm01cTVoRm1qaFMxbnZ4bEx1MG5zTC9oT09vMWFS?=
 =?utf-8?B?MFRtWUdkankzRkxXNHA1cjJyV1JiOWU2aHY5TUJ0UzhrUFdmMUhBZFZpYXRX?=
 =?utf-8?B?TVJCUkNPT0p1MXpzQUszajNMMXpVMTluaFZyWmpRNXZRR0pUbFBNcVVUemhu?=
 =?utf-8?B?U2IvcThXM3hyZTc3d3NIMHFzanZoeUQyMGpLK1JsUGdWQmdVMkVLbXJIQSt4?=
 =?utf-8?B?djROZmx5SHNuQ0M2blhURHdiZ0JTYWU1cWQrKzFldGMvazFEN2xnRlNuc0FN?=
 =?utf-8?B?TkFnaUQwS0cwdDBqSVZ1UFVia0tHYXgrTWpuWjRNaHVDdVM3YVJVc2FHcTI4?=
 =?utf-8?B?a3N6SkxaWEl2ZEpncVJKWGl6UGRCVFZJQ1ZsY2h0Z0RxUTVKU2ROS2JxU1lW?=
 =?utf-8?B?NFlZKytvYnRTODJ5ZXdGRExVWFFhTDlrcHN1ZmZuZ3I4WWxibDNkSktYTGtB?=
 =?utf-8?B?RXRGdzNiazJTdlNnbzJhOE9DN1UwMEpKL203NEpqdnY5dkJaWkFIUjYzQzFF?=
 =?utf-8?B?amxHU1NBU2xYU2p4S0hGRWxWaWgydEVSV2xiU3VyL0tEK2ZxeHRlT1N4MDNK?=
 =?utf-8?B?K2o0ZWgzdTZUY0JTRHJadFZjekQ1MER5TzEvdkROTWZneG5kYVRzYllKVlZQ?=
 =?utf-8?B?akxac2FwNHlMRmVwaXd1cTUwdkVNNXNTd2wzTmJNRTdLdzkydjZUbUI1bnpV?=
 =?utf-8?Q?qSc6LDsu/6xXmgmfaf3nbhRhz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB58F186C2D85449AE6F4E20EB68899F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cktPckRuNEYwT3lUVVV1QnhHcVRkNXNSTUovajJJM09Rbm1tRGZQcUdVVE45?=
 =?utf-8?B?TkFtWjBCQzhnaVNCQmJSRTAwQmhiTTNza0tuZHo2ZW05SUpqQXVLYzJFeHNG?=
 =?utf-8?B?bDlvQ3hGQkdGcE45SkMzZzRxS2srQ3hCMGMzV1JsTUsrcDVZZWxNdklUTGx4?=
 =?utf-8?B?Z2sxcGx0R1J3VUhXRGtlbUp4SzVLQmRoM01Ya0wybXNGMjJqbytRbVluUXI1?=
 =?utf-8?B?S21UZWdDeVZwN203UFVVdGdVY0x0aGs0TittbXR2QWwxQVk1eW9IcnIzZm1k?=
 =?utf-8?B?bkpRQVpsbEYyU2ZWaklkYTB6V0NoV015c2p3OEhLNUUveDFkS2hWaThjRUhw?=
 =?utf-8?B?a2pMTVRuK0FucGpBNXpyVTVoaE9ZdVJWN3RKZXR4ZTM2ZFVKb3R0YzJSQWZM?=
 =?utf-8?B?R2hBZ0w1cDJaNldqVzNEZVN6NjdyVHZnbFROd0t2VkcyNi82SGlHUWFBVjY0?=
 =?utf-8?B?SDFnVWRiaDFvbHlteVh3aWRVRzQwaE5UV3FKRk9WcFQ2bGlVdTNqZjdtUXM0?=
 =?utf-8?B?NWtpYmxSRXRUNXh3QS9xbVdyWkhRUU40VWRrVHVyN0RZYThtVHZPNzJzN1Fi?=
 =?utf-8?B?aHpQY25TaUxXaEI2Rm5rL0FLM0RZUi9abURpMDQzM0NDSFVBUm5zYlF1UzRn?=
 =?utf-8?B?QzVVM0lyRENRd2JXUUZEME9rRXU3V091YU9KWVRvZk9yOE51N3hpWUVHdkRW?=
 =?utf-8?B?RlZrYVYyTUhoNmtxUU5yVE5rcVNZYzZrMEN2SVRLdHNiWE5JVkZqNEZnR1Ux?=
 =?utf-8?B?enBXT0RpYUV4UFhvS0FWZFBsOFlkeitNQ1BOWEJxY0JSdDYwQ1BNMTdNVTBx?=
 =?utf-8?B?SXFUVnpmazEvUmhMYjFja3dUU2lSNDI1NUFjSVVKUE9KYXpRVFFwVGZnMVgx?=
 =?utf-8?B?Um5YcEF0M0NoN2s3UURMLzNGaVk5MjNmYnFzOTJ2TnFqRGI4VjA4V01iWVRR?=
 =?utf-8?B?RVpjbmx0Z3k3RjZjSVNvMmZNWGlkYzZGczFqWkNnOGJnNnBpbC9ZaHc1dHhY?=
 =?utf-8?B?ZXBnQ1VYbnJkemRWc1Z0UStjL0tyenNSckM2R2U2MEkvVDhQTi9XVm1oL3Jz?=
 =?utf-8?B?NGVsUG5ObCtsOWJNUmt6bkNBZVVTQ28wTmRCYjNlVnI2bzdUZHBabHFnUVBz?=
 =?utf-8?B?WGdpVHQ4dzBJRGdiWC9vb0t3RnJCNHl2NWJQVXFjaktmeUdoYjdGR0tjY0xI?=
 =?utf-8?B?cDZCaGJnMmZ0WjNrR2lGYTJXSXVkM2k3dzkxMis5azNFVnRYU0htRjJiM05I?=
 =?utf-8?B?TkdsRHV2NC9zekwxaVpuOHlqQ2JFSlhEbFQ0d1A1MGpOUDIxZkw5TnU2em8w?=
 =?utf-8?B?VzNqYUNSeFpPWk12ZUd1Z3QvMlMxWG80SVpCRUx6UFpUdXJDSERMTFRENFNM?=
 =?utf-8?B?TUZoMmxsTmtoYWFUbzBaS0xHL21OdHE1YUJtMFlFcVVoRjM2azBjUGF3WDdv?=
 =?utf-8?B?eG9NYS94SFFHSERtWlE3YnFBdHhhS05JWFUyZWtRPT0=?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248bb434-990f-4fb9-e1ab-08db3fcaa011
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 05:06:10.4472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bj3X6ANlTYGpXLGuSifCIa2qpsrEdXI+0EFe2X/JboJY9M7TtIldBSL0an739Ol7mTUZRMkREauR8XXlvUcbXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
X-Proofpoint-ORIG-GUID: XQq01fP0Jlb2tvvN-5Benmuq3qyRsGjg
X-Proofpoint-GUID: XQq01fP0Jlb2tvvN-5Benmuq3qyRsGjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_02,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304180046
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNC8yMyAxMjo0MSwgRmFicmljZSBHYXNuaWVyIHdyb3RlOg0KPiBBZGQgc3VwcG9ydCBm
b3IgdGhlIHV0bWkgY2xvY2suIEl0J3MgbmVlZGVkIG9uIFNUTTMyTVAxNSwgd2hlbiB1c2luZw0K
PiB0aGUgaW50ZWdyYXRlZCBmdWxsLXNwZWVkIFBIWS4gVGhpcyBjbG9jayBpcyBhbiBvdXRwdXQg
b2YgVVNCUEhZQywgYnV0DQo+IEhTIFVTQlBIWUMgaXMgbm90IGF0dGFjaGVkIGFzIFBIWSBpbiB0
aGlzIGNhc2U6IEZ1bGwtU3BlZWQgUEhZIGlzIGRpcmVjdGx5DQo+IG1hbmFnZWQgaW4gZHdjMiBn
bHVlLCB0aHJvdWdoIEdHUElPIHJlZ2lzdGVyLiBUeXBpY2FsIERUIHdoZW4gdXNpbmcgRlMgUEhZ
DQo+ICZ1c2JvdGdfaHMgew0KPiAJY29tcGF0aWJsZSA9ICJzdCxzdG0zMm1wMTUtZnNvdGciLCAi
c25wcyxkd2MyIjsNCj4gCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+IAlwaW5jdHJsLTAg
PSA8JnVzYm90Z19oc19waW5zX2EgJnVzYm90Z19mc19kcF9kbV9waW5zX2E+Ow0KPiAJdmJ1cy1z
dXBwbHkgPSA8JnZidXNfb3RnPjsNCj4gCXN0YXR1cyA9ICJva2F5IjsNCj4gfTsNCj4gDQo+IElu
IHRoaXMgY29uZmlndXJhdGlvbiwgVVNCUEhZQyBjbG9jayBvdXRwdXQgbXVzdCBiZSBkZWZpbmVk
LCBzbyBpdCBjYW4NCj4gYmUgcHJvcGVybHkgZW5hYmxlZCBhcyBhIGNsb2NrIHByb3ZpZGVyOg0K
PiAJY2xvY2tzID0gPCZyY2MgVVNCT19LPiwgPCZ1c2JwaHljPjsNCj4gCWNsb2NrLW5hbWVzID0g
Im90ZyIsICJ1dG1pIjsNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZhYnJpY2UgR2FzbmllciA8ZmFi
cmljZS5nYXNuaWVyQGZvc3Muc3QuY29tPg0KDQpBY2tlZC1ieTogTWluYXMgSGFydXR5dW55YW4g
PGhtaW5hc0BzeW5vcHN5cy5jb20+DQoNCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gInV0
bWlfY2xrIiByZW5hbWVkICJ1dG1pIiBhcyBwZXIgS3J6eXN6dG9mIGNvbW1lbnQgb24gZHQtYmlu
ZGluZ3MNCj4gLS0tDQo+ICAgZHJpdmVycy91c2IvZHdjMi9jb3JlLmggICAgIHwgIDIgKysNCj4g
ICBkcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMgfCAyMCArKysrKysrKysrKysrKysrKysrLQ0K
PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzIvY29yZS5oIGIvZHJpdmVycy91c2IvZHdj
Mi9jb3JlLmgNCj4gaW5kZXggNDBjZjI4ODBkN2U1Li4wYmI0YzBjODQ1YmYgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvdXNiL2R3YzIvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzIvY29y
ZS5oDQo+IEBAIC0xMDAzLDYgKzEwMDMsNyBAQCBzdHJ1Y3QgZHdjMl9ocmVnc19iYWNrdXAgew0K
PiAgICAqIEBjdHJsX291dF9kZXNjOglFUDAgT1VUIGRhdGEgcGhhc2UgZGVzYyBjaGFpbiBwb2lu
dGVyDQo+ICAgICogQGlycToJCUludGVycnVwdCByZXF1ZXN0IGxpbmUgbnVtYmVyDQo+ICAgICog
QGNsazoJCVBvaW50ZXIgdG8gb3RnIGNsb2NrDQo+ICsgKiBAdXRtaV9jbGs6CQlQb2ludGVyIHRv
IHV0bWlfY2xrIGNsb2NrDQo+ICAgICogQHJlc2V0OgkJUG9pbnRlciB0byBkd2MyIHJlc2V0IGNv
bnRyb2xsZXINCj4gICAgKiBAcmVzZXRfZWNjOiAgICAgICAgICBQb2ludGVyIHRvIGR3YzIgb3B0
aW9uYWwgcmVzZXQgY29udHJvbGxlciBpbiBTdHJhdGl4MTAuDQo+ICAgICogQHJlZ3NldDoJCUEg
cG9pbnRlciB0byBhIHN0cnVjdCBkZWJ1Z2ZzX3JlZ3NldDMyLCB3aGljaCBjb250YWlucw0KPiBA
QCAtMTA2NSw2ICsxMDY2LDcgQEAgc3RydWN0IGR3YzJfaHNvdGcgew0KPiAgIAl2b2lkICpwcml2
Ow0KPiAgIAlpbnQgICAgIGlycTsNCj4gICAJc3RydWN0IGNsayAqY2xrOw0KPiArCXN0cnVjdCBj
bGsgKnV0bWlfY2xrOw0KPiAgIAlzdHJ1Y3QgcmVzZXRfY29udHJvbCAqcmVzZXQ7DQo+ICAgCXN0
cnVjdCByZXNldF9jb250cm9sICpyZXNldF9lY2M7DQo+ICAgDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMgYi9kcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMNCj4g
aW5kZXggYzQzMWNlNmMxMTlmLi41YWVlMjg0MDE4YzAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
dXNiL2R3YzIvcGxhdGZvcm0uYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMN
Cj4gQEAgLTEwMSwxMCArMTAxLDE2IEBAIHN0YXRpYyBpbnQgX19kd2MyX2xvd2xldmVsX2h3X2Vu
YWJsZShzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpDQo+ICAgCWlmIChyZXQpDQo+ICAgCQlyZXR1
cm4gcmV0Ow0KPiAgIA0KPiArCWlmIChoc290Zy0+dXRtaV9jbGspIHsNCj4gKwkJcmV0ID0gY2xr
X3ByZXBhcmVfZW5hYmxlKGhzb3RnLT51dG1pX2Nsayk7DQo+ICsJCWlmIChyZXQpDQo+ICsJCQln
b3RvIGVycl9kaXNfcmVnOw0KPiArCX0NCj4gKw0KPiAgIAlpZiAoaHNvdGctPmNsaykgew0KPiAg
IAkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGhzb3RnLT5jbGspOw0KPiAgIAkJaWYgKHJldCkN
Cj4gLQkJCWdvdG8gZXJyX2Rpc19yZWc7DQo+ICsJCQlnb3RvIGVycl9kaXNfdXRtaV9jbGs7DQo+
ICAgCX0NCj4gICANCj4gICAJaWYgKGhzb3RnLT51cGh5KSB7DQo+IEBAIC0xMjksNiArMTM1LDEw
IEBAIHN0YXRpYyBpbnQgX19kd2MyX2xvd2xldmVsX2h3X2VuYWJsZShzdHJ1Y3QgZHdjMl9oc290
ZyAqaHNvdGcpDQo+ICAgCWlmIChoc290Zy0+Y2xrKQ0KPiAgIAkJY2xrX2Rpc2FibGVfdW5wcmVw
YXJlKGhzb3RnLT5jbGspOw0KPiAgIA0KPiArZXJyX2Rpc191dG1pX2NsazoNCj4gKwlpZiAoaHNv
dGctPnV0bWlfY2xrKQ0KPiArCQljbGtfZGlzYWJsZV91bnByZXBhcmUoaHNvdGctPnV0bWlfY2xr
KTsNCj4gKw0KPiAgIGVycl9kaXNfcmVnOg0KPiAgIAlyZWd1bGF0b3JfYnVsa19kaXNhYmxlKEFS
UkFZX1NJWkUoaHNvdGctPnN1cHBsaWVzKSwgaHNvdGctPnN1cHBsaWVzKTsNCj4gICANCj4gQEAg
LTE3MSw2ICsxODEsOSBAQCBzdGF0aWMgaW50IF9fZHdjMl9sb3dsZXZlbF9od19kaXNhYmxlKHN0
cnVjdCBkd2MyX2hzb3RnICpoc290ZykNCj4gICAJaWYgKGhzb3RnLT5jbGspDQo+ICAgCQljbGtf
ZGlzYWJsZV91bnByZXBhcmUoaHNvdGctPmNsayk7DQo+ICAgDQo+ICsJaWYgKGhzb3RnLT51dG1p
X2NsaykNCj4gKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGhzb3RnLT51dG1pX2Nsayk7DQo+ICsN
Cj4gICAJcmV0dXJuIHJlZ3VsYXRvcl9idWxrX2Rpc2FibGUoQVJSQVlfU0laRShoc290Zy0+c3Vw
cGxpZXMpLCBoc290Zy0+c3VwcGxpZXMpOw0KPiAgIH0NCj4gICANCj4gQEAgLTI0Nyw2ICsyNjAs
MTEgQEAgc3RhdGljIGludCBkd2MyX2xvd2xldmVsX2h3X2luaXQoc3RydWN0IGR3YzJfaHNvdGcg
Kmhzb3RnKQ0KPiAgIAlpZiAoSVNfRVJSKGhzb3RnLT5jbGspKQ0KPiAgIAkJcmV0dXJuIGRldl9l
cnJfcHJvYmUoaHNvdGctPmRldiwgUFRSX0VSUihoc290Zy0+Y2xrKSwgImNhbm5vdCBnZXQgb3Rn
IGNsb2NrXG4iKTsNCj4gICANCj4gKwloc290Zy0+dXRtaV9jbGsgPSBkZXZtX2Nsa19nZXRfb3B0
aW9uYWwoaHNvdGctPmRldiwgInV0bWkiKTsNCj4gKwlpZiAoSVNfRVJSKGhzb3RnLT51dG1pX2Ns
aykpDQo+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGhzb3RnLT5kZXYsIFBUUl9FUlIoaHNvdGct
PnV0bWlfY2xrKSwNCj4gKwkJCQkgICAgICJjYW5ub3QgZ2V0IHV0bWkgY2xvY2tcbiIpOw0KPiAr
DQo+ICAgCS8qIFJlZ3VsYXRvcnMgKi8NCj4gICAJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUo
aHNvdGctPnN1cHBsaWVzKTsgaSsrKQ0KPiAgIAkJaHNvdGctPnN1cHBsaWVzW2ldLnN1cHBseSA9
IGR3YzJfaHNvdGdfc3VwcGx5X25hbWVzW2ldOw==
