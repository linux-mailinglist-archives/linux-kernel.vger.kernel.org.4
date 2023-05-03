Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECEF6F60A9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 23:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjECVzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 17:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjECVzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 17:55:39 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B5776B4;
        Wed,  3 May 2023 14:55:38 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343J8W7I023939;
        Wed, 3 May 2023 14:55:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=MvwrLpAGNkxXix4Uu5A3BjPbn8kg+MZACURA93lDgPQ=;
 b=avrSsXf2uc8tbGQ/Xw1Dv8VuinXqkJlnIAXoih4GT7scylwxqNH3ORl90+vmeyMT8pES
 PadV2rVYAnF6ei3X5qgfeEdivdOEhFl4jM/5F95MrwJftEiSyK7NQxTJkHpjdGg1CMr+
 SccKkpmvd4NaEQTV1Uu0pzPfEDsjsWD4RUPmcYgoCgDMjYjdb/HU7gchMJ9/iLRBWWDA
 x6oXdxDe1g+3qPEqTWAuchIrBilURNLmIze3ZkzmICfz4qxdhjhB88UDvpqMUGCRPWJA
 BEUnYj36FWJAxmQ5Q6Lx6VrRTulYPvg8lPlNG8j9x5vOg321qf/e3ksgVfMiG22ILZWw TQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3q92g9ka9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 14:55:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1683150922; bh=MvwrLpAGNkxXix4Uu5A3BjPbn8kg+MZACURA93lDgPQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=dRJZ/BhVnUdyJaEyv4qU91Uafws009JiqCOmAEUKVlu73FjFyGtYhklxnKQRPH1+z
         6Q67nVO0qtiwB/Ak6jcmag0wWCVEx/FrWhJKdaGwl3jGqkcBa2Cho4WRaQJGfq4j0u
         MC9f9Juaj3GSLmnyiZC62t4tR5jVLUDSrRWn3BVuIyOZkMmMtC3C9KnZVVhT7jPa/t
         DRhb7H6CG2GW83CfQIF30NEvXoFtjhpqMX23bWBB2hu+9DK4Dylj+QJtHm1UopbWMu
         AS0KDrX93T+4Qwv/LXbWfbGKijYNOX1pt1GkgB/FQBqXOGF8NfMf1kH7ZgV2nI8kPI
         0zpLNt+qlbvcw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CEA9F40520;
        Wed,  3 May 2023 21:55:21 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id A1390A0096;
        Wed,  3 May 2023 21:55:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=OpV7fYbo;
        dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1FA2040751;
        Wed,  3 May 2023 21:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwJFzY+49ROc4wc8cqZMKW3C4IdhzoQ9I8FCBdDxWVjOoefxIvita8JrrH4+gu8jAkPl5pfSv2sMtRkBbzPasC6HY+eKlOdFEVMSSE1nPcDd5gxtSodrMZeEeD1gpnQt2H9zIgiM7X5RjJO/tgg8c51IRBeFW6CvApCceLpeyVRluQRbezVS30T7SklGoa11qOR12AjNfuN9QcxsYvz3OzjJXnN8+pQo6c8wciWZ08ZG1S9cHKBu163wqvkE3yw/PBZgw6tkJw1b9hPEqtgKExpUTl7wmkRIHEnwvDZa6CdHa52vLZ4A4e97osiscVkFS7q6rFI0WPc678iinZhvAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvwrLpAGNkxXix4Uu5A3BjPbn8kg+MZACURA93lDgPQ=;
 b=gmnDW7EkkNKIvZSmLBTIV1wHejhY92RPpfKA0yOKY1TLsBcE+LUt4g2PYT7E3UybwBjl9mC+sKsstNI5ASfP8RIW0V++vbrRYnQHIYaMYbaN/ro3pTyapwybUTXX5n9RbJz1n5Y0pKH9/PU6QzTYZ5i/veDeEnrzs7HnBsQdqgGwx6+tCIAqCK+NOITbSRbVn3l+dfTl6mrw5egXdXLS0B9EWw9UgH1Vgi4bfTgADcvPg5Ts9wOZX05yPKUFQj7R/BVlb3Ut9GFMjIivAS/u1stxeJuw1qA8Y5/IHNjooNT2GRqZnBIN9C8aE8klYtH/PeSNbrFZoAKSn/OacYmkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvwrLpAGNkxXix4Uu5A3BjPbn8kg+MZACURA93lDgPQ=;
 b=OpV7fYboFyfxS3ORHRawb6rJuweMPP4mENxrYqncDGDCfz++6v3Ft5d0NFxUUXnNyueAbJeKKnzS95HC5mVqE4F8L+rAm1Dsl6EEZC9AIVwTFBzvpavHALTZPFUyan60p584+viya6+La0ZmsQ5b7vsfehfCmncA8le+08hmqwo=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ2PR12MB8649.namprd12.prod.outlook.com (2603:10b6:a03:53c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 21:55:14 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 21:55:14 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v7 5/9] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Topic: [PATCH v7 5/9] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Index: AQHZfDo588fWoaeNiEaAxdpNf9JXza9HjX8AgABfX4CAAS6LgA==
Date:   Wed, 3 May 2023 21:55:14 +0000
Message-ID: <20230503215511.52udfef6amdcapng@synopsys.com>
References: <20230501143445.3851-1-quic_kriskura@quicinc.com>
 <20230501143445.3851-6-quic_kriskura@quicinc.com>
 <20230502221100.ecska23anlzv3iwq@synopsys.com>
 <f55fbdc1-444c-eba5-02f4-aeab7a1b6f04@quicinc.com>
In-Reply-To: <f55fbdc1-444c-eba5-02f4-aeab7a1b6f04@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ2PR12MB8649:EE_
x-ms-office365-filtering-correlation-id: 911909f2-a48e-4b48-da32-08db4c211370
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c42ie5BMrB4+c9PGLGPAbwH1NkDFmzpsoGTbg4Ry30bsDQtrV1bSlwXMUZ3UjdfFZPW0tSzplBit4z0V/xRYt2ZPwQXS/Y7PpWe4+5Gf5c4yP6Vwfv4j1e4nMY/cx/O1IYjyg5xX/Bwe+FLQ9a/rJc6s7BrbKLPUMa7dlFCGTYQYBmB8HMmh8NEgf5GHA3ehh9Sz9MJtaNz2b2Di/w+55xi0s54787mbCYxoCvx9fyCG1a/c6GGIjSZgicbvA9ayaRG8VetwQET1+yI4u/lCWMEUHONVzjWi5cpMIQF64zDvaXhXqfqmUqObJ9Nrr3FqBQ5l9DqEgYvCPI0pe+5mGZI+OQfKeLHF4Ok3/v1tWTSPGOy2k6GoT6O7Puw7fn+8odoS3mIjR/nFBg4h7C6oCBhDIJVjBMVCUBSix37XG43nO5vMkdpdc54x3SGfZ9Fo7bxHdPnFN4bs053R7OS5/MZbB7rUQ//QGwJETp2aWNDmcwJpfcI7k99CVOhQnvBNw0ytMMY/A4kVj7oXUjFFXAb3yE8xCEAcWwKs7RjN6HYi9y3C8GzwVBbtxyKa2GQSrlWpmztpUL6iPPcwT80gEZkKW2lfQBJ25g9HevOugLAe9Zb3pyRAtwdfiXgfWLpn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(86362001)(5660300002)(7416002)(8676002)(8936002)(4326008)(64756008)(66476007)(66556008)(66946007)(76116006)(66446008)(122000001)(41300700001)(316002)(38100700002)(38070700005)(6916009)(2906002)(186003)(53546011)(6512007)(6506007)(1076003)(26005)(6486002)(71200400001)(83380400001)(36756003)(54906003)(2616005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEY2b0M2bkZiKzRhYit6VzQ3NVlEYU02Qm8xMDdaVmkyVzZkR1B4aTI1OE5h?=
 =?utf-8?B?RklwejhtMW8rTTJOSFAyenI3ekE0ZncvN212dUc1Ykx6ZTlwbVhLTVhKLzQz?=
 =?utf-8?B?M3JBSGhORWtKT2pZTnFMR1pGL2U2VDV6azE3SEJFb25QRHdsNk85YVcwNzAw?=
 =?utf-8?B?bG5SZWFhMHdVa01PcTJ4aHBpOXdOVDdwK1NNRXJLWHR2MG0rRHVXQmF2SjJI?=
 =?utf-8?B?VkRXeElhRXVOOU51M2FQMHlYWHRORVB4U09IUGNoZmJyMFlVV0VZMkEvR3Vz?=
 =?utf-8?B?SEJFMndvT3AyVHhiSlZQV2VFMUhqbE14Q3hZWXYrRW11M3BwTmdidzViQnJX?=
 =?utf-8?B?RWxpUmN0dVJZRUgvaEpOY1BMQi80V1pNY01BU1JUdGFEV2RxcTd3bzZ2Wmx0?=
 =?utf-8?B?TjM3M0xPY1VSVUlqazB6UmNFVzJQZDJ1aUJSc2NneGJkeXU0MWh4eUlmVTV0?=
 =?utf-8?B?QW9LUXpFTnp0VFhwNHNTQVZQVUhyZFh4V0pzT0pDQjVFc2kyZFc2MUJRdUlr?=
 =?utf-8?B?Y3JEQzhGSHBVZ1ZkL255ZFpQRUdmdm1LZjJDTVMxSmZzN2xQa3hEamVPVk5V?=
 =?utf-8?B?c1pVWXNUbTBXM3pRVE12Z1ZqaTVRRkYxTDl4b0duOEt5ZUZWT1k1VjZBdU43?=
 =?utf-8?B?WkdCbytNOXMyYkpzVWVRUk45MXplUC9lYWo3MWRhemVkSldsbWs4TEw1Vmtq?=
 =?utf-8?B?bXFhQkNNOWpxSE5HelM3YjVQYlNCdUJrOWpMeEVYV3UySk9BZGpjT1d2UjRm?=
 =?utf-8?B?ZU1uMTFjT2N0cGVwMUlZcmNYWHhHZFFsRTVPeDIxNkdjQ0tuejJMOG0rMlZF?=
 =?utf-8?B?RVc4bmRqdnRuMTZwZ1lNZDlTd01tT3MvbHpLL3FEaWpjdkkwV3JHNWJjclNz?=
 =?utf-8?B?T0QrVG5WLzlkbUNnYi9Ta3QzK05XNXJ0RTBHNXRwVTZxeWNlWGYyZ2MxN3BP?=
 =?utf-8?B?Y0d3WVNzZlArdHZFWE1BUWUrR0RyZ0kvNmtxaVYwalY1MUYrN1QrZDRJam52?=
 =?utf-8?B?b2IwcGhYSUd1R3RHekUzTHJPYnF4aEtQSnNaN1BvdmxQOW51a2ppYWZ0eDIz?=
 =?utf-8?B?SGl6Nk5DeS9hUE5XZDNMc1U3TElVL0F2eGJIdkdvcExhaHNta00xRW5VR3Z4?=
 =?utf-8?B?UlliRU5qdWNkdDlwY2V4N0VPM3p6c2JIQktCMzFNN0JzSXgzWGUyWXJTTXVl?=
 =?utf-8?B?U2FmRGdVMXJyU0l4TzRqU3FuN0pqMitTUUl6ekRCbnpURXNzTnE2Y1N0c0F1?=
 =?utf-8?B?UjF5cGkyaHY5Sm91M05zUEhsZGduUVk1TlQvMU04Q1lza25udGdjZ1JFY1hR?=
 =?utf-8?B?blNqY0R5eFVqVXpsa3VrNlBpY1ZHTEg5akZoQXBjVGRoY0lXbGdYQzM1TzlK?=
 =?utf-8?B?VHk2SHB1TCt6T0dLcGhtcHVwMWJvbG52SEZuM28vai9raEZ5aENqMUlmSkVL?=
 =?utf-8?B?d1FVQzFYT09RbklRWXh2eUhkWmZqQ29seVBDNnMrZjF0SlorUWN3Y21UamM1?=
 =?utf-8?B?RGVxV0pRQU5tNVdaOVlITnlxWWJpQ3ZvUzlRYmltZ2FSQytYZmRpWTU0WGRV?=
 =?utf-8?B?STZrTFU2UFVucS9udkhPTkNHM29paGt1MFMyQmIwL05BNGRWRS8vbGtlYzlR?=
 =?utf-8?B?VUJIWEYyVE1Rd3JUNFBubkNtNE9ZVUFWb3BpeUlWVzBBaFNoVGJacEdEaWM1?=
 =?utf-8?B?MjJaYWw0S3BTZEQwSHdvTDhKVUp5Mm9kM2M4Z0htRjRTeXNQMUF3c1dOVGpt?=
 =?utf-8?B?YncyRHhIejZweTUwN2UraVM0cHpEUGpGd3lWVzhLbXBhQmd4MmNnRVM4WG41?=
 =?utf-8?B?bWRIME4zeG9zVlJpdVJOVHpVQ3VkZlhYb1gxbTlPQzdpazJXVDRxUkloTTJO?=
 =?utf-8?B?dHJpalE2c0NJWjV6dkVtQTMySlNNL1JaV3F2VEtBcGp6aXlaOEdISFZ1cHNR?=
 =?utf-8?B?M2FtZ1VUQVozZ3QrM0hiZE9TaDJXc2NsdFI5M2xIajBrWW0xKzVNQWV2Smpw?=
 =?utf-8?B?T0JISzdCa3RiaDE1MkE2SmJDQ2NsSXl5UG5nWFBwVU9VeFhPbm1ZTWhrb0xx?=
 =?utf-8?B?dlk5eFNKZXBsNlRtM2xnMUdXNlovaDArNlIrSDBFQWRCWkxjSkZmUENaTld6?=
 =?utf-8?Q?2FR/aIJ5AbpV6+gJn55Tn3shU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E163D9B830D0F14899757C5B54EB9DFB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d3k0MUV0cDJoWFY4cHdkUFdRMW9CME4xdnNvYjV0cHFLcnBiRkU1S2RvajhL?=
 =?utf-8?B?bFZkY1dFRURxOFI2VlB4NVI0b1dpdHdKUmpmdUtMK21qQlNBYVBuazhkaTV2?=
 =?utf-8?B?aEVQTFZhVzBUTFlJc2RFcHp5emFXdGRaM0tZYmdnY2FBYmJFQTZWMGs5Z1po?=
 =?utf-8?B?ODRyZWJZNDhhU0Z1cDZPaVUraGNEY2lQN2J3N2M5Njc4b2lyb2cwbWpJYVRk?=
 =?utf-8?B?T2g1V0FLd2JsRmxYZ1JkeFc4SlZ6VVJFUy81aTM3d3pQMkcvVmNsWnVGdkVt?=
 =?utf-8?B?aERZNG9tWVRVQ2ZuUGUwUFJVa3dHa2huLzMzMVNhWUZNL2NNUkpHK255eE84?=
 =?utf-8?B?aEhqUWlUVDZGSnBFOTdLRjIxOEo1cFBoMUFpbmoxTDVzdFJLQWhRZ3Byekdz?=
 =?utf-8?B?Z2xkeDdtQUhxcVRsNGRTUVZmOFc2V0tML1FiS045QXJONjVEcFI2dG52N29T?=
 =?utf-8?B?K3RGL0JwUkRLOUdLSVREYVhDc0FUbUUwWDZhanFGdlhHZS80aHJjczJWNVEx?=
 =?utf-8?B?Y2hMajJJazhRdFVpNDY3L1hCV3h1ZHZMTURxWWpIRHNFcGo2WllsKzZIYS8w?=
 =?utf-8?B?bTFFNkt3OEN4UFdKY29BSUdYOFVUMzNmUmhCaHk3UytFa2cwSHJWdlVJTnNH?=
 =?utf-8?B?QjhtUm1JVm4rRlhtTzdBbnpaVUlqR3dQeHhBbWFIbC9ZODhWVC9MSUVicE1K?=
 =?utf-8?B?MUJVYWxiNXEydjh2OEh4ZjZlcEVrMG10WkJrUjY3dUZWWTNCTGcyRVNKK3Vs?=
 =?utf-8?B?dE52UTk2YWZvS29TVk1VbnNEdW1wY2JuRE9KemhIWENRNHRybnI1czlKdGlE?=
 =?utf-8?B?aEtRbXhjdWx6NkNYOVAxVzJVRlE1SXNqYVprdkNndUJSVVdrLzNUWVNwSDB6?=
 =?utf-8?B?NzMrSFIxbHZsTkZERFJ0SlFPcWsvdzR2anZZdHRCT3F6Ly9vSW5PQkdQaEVr?=
 =?utf-8?B?V3MzdTVPUWZxZzZTNGhEbld1dmI0bVMwYXcyQlNaTWFpdWJ6OEJUZ0tqcTU4?=
 =?utf-8?B?c3Fuc09HbkpxYTA0OVJPWlJzamVubTE5T3UzNi96WllNaEZnNzRidUJLUmxP?=
 =?utf-8?B?T3lwNCtwVkVFa3RFc3A4c1RVTUN6bjZOZ3NZeVZFSDRnZ1AxVndreGJlcldy?=
 =?utf-8?B?eUtyNHZRaTVINFdtTmdkWURoU1llZ09JQ1dQOFBROHpwSWp3ampFK04xY1h0?=
 =?utf-8?B?a3BBTWtFOXN4ZnowUHhScG1RYlNSL1lYUzUxZFo3NWFSTVpuek1oQUJPY2Ez?=
 =?utf-8?B?Y20vR3QzYnh2aW1tNi84THFjNEt2VmZISHlIb3RUdkJLWWhxMXhlVU1YalZm?=
 =?utf-8?B?dk84ak1kRXppY3ExQ21tUlJsSGR5TkJWU2NlVUEwbkRJVzdsc0xRd3haUjdI?=
 =?utf-8?B?b1l0ZERTeFlob0E9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911909f2-a48e-4b48-da32-08db4c211370
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 21:55:14.6595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6osXqqh9ihON6aRIilUbRyysk0RuXF09ECJJG+wdwn41crZnLFP9AtmZcQp61dbFMmY6gARAh5RaVt5jSd9C9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8649
X-Proofpoint-GUID: hTeZ1IBYTl2KOuDVMavhzZkYZc1cJCtO
X-Proofpoint-ORIG-GUID: hTeZ1IBYTl2KOuDVMavhzZkYZc1cJCtO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=856 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMDMsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNS8zLzIwMjMgMzo0MSBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIE1v
biwgTWF5IDAxLCAyMDIzLCBLcmlzaG5hIEt1cmFwYXRpIHdyb3RlOg0KPiA+ID4gQ3VycmVudGx5
IHRoZSBEV0MzIGRyaXZlciBzdXBwb3J0cyBvbmx5IHNpbmdsZSBwb3J0IGNvbnRyb2xsZXINCj4g
PiA+IHdoaWNoIHJlcXVpcmVzIGF0IG1vc3Qgb25lIEhTIGFuZCBvbmUgU1MgUEhZLg0KPiA+ID4g
DQo+ID4gPiBCdXQgdGhlIERXQzMgVVNCIGNvbnRyb2xsZXIgY2FuIGJlIGNvbm5lY3RlZCB0byBt
dWx0aXBsZSBwb3J0cyBhbmQNCj4gPiA+IGVhY2ggcG9ydCBjYW4gaGF2ZSB0aGVpciBvd24gUEhZ
cy4gRWFjaCBwb3J0IG9mIHRoZSBtdWx0aXBvcnQNCj4gPiA+IGNvbnRyb2xsZXIgY2FuIGVpdGhl
ciBiZSBIUytTUyBjYXBhYmxlIG9yIEhTIG9ubHkgY2FwYWJsZQ0KPiA+ID4gUHJvcGVyIHF1YW50
aWZpY2F0aW9uIG9mIHRoZW0gaXMgcmVxdWlyZWQgdG8gbW9kaWZ5IEdVU0IyUEhZQ0ZHDQo+ID4g
PiBhbmQgR1VTQjNQSVBFQ1RMIHJlZ2lzdGVycyBhcHByb3ByaWF0ZWx5Lg0KPiA+ID4gDQo+ID4g
PiBBZGQgc3VwcG9ydCBmb3IgZGV0ZWN0aW5nLCBvYnRhaW5pbmcgYW5kIGNvbmZpZ3VyaW5nIHBo
eSdzIHN1cHBvcnRlZA0KPiA+ID4gYnkgYSBtdWx0aXBvcnQgY29udHJvbGxlciBhbmQgbGltaXQg
dGhlIG1heCBudW1iZXIgb2YgcG9ydHMNCj4gPiA+IHN1cHBvcnRlZCB0byA0Lg0KPiA+ID4gDQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBIYXJzaCBBZ2Fyd2FsIDxxdWljX2hhcnNocUBxdWljaW5jLmNv
bT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFA
cXVpY2luYy5jb20+DQo+ID4gDQo+ID4gQXJlIHlvdSBhIGNvLWF1dGhvciBvciBvbmx5IEhhcnNo
IGlzIHRoZSBtYWluIGF1dGhvciBvZiB0aGlzIHBhdGNoPw0KPiA+IA0KPiBIYXJzaCBiZWdhbiBk
ZXZlbG9waW5nIHRoaXMgc2VyaWVzIGFuZCBwdXNoZWQgdGhlIGZpcnN0IDMgUkZDIHZlcnNpb25z
DQo+IChzdXBwb3J0aW5nIGJvdGggdXNiLXBoeSAvIGdlbmVyaWMgcGh5IGZyYW1ld29ya3MpIHVu
dGlsIG1haW50YWluZXJzIHBvaW50ZWQNCj4gb3V0IHRoYXQgd2Ugb25seSBzdXBwb3J0IGdlbmVy
aWMgcGh5IGNoYW5nZXMuDQo+IA0KPiBGcm9tIHRoZW4gb24gSSB0b29rIGl0IHVwIGFuZCBzdGFy
dGVkIHB1c2hpbmcgbmV4dCB2ZXJzaW9ucy4gSSB3b3VsZCBzYXkNCj4gYm90aCBvZiB1cyBhcmUg
cHJpbWFyeSBhdXRob3JzIGZvciB0aGlzIHBhdGNoLiBCdXQgaWYgdGhlcmUgaGFzIHRvIGJlIG9u
bHkNCj4gb25lLCBJIHdvdWxkIHNheSBpdHMgSGFyc2guDQo+IA0KPiBSZWdhcmRzLA0KPiBLcmlz
aG5hLA0KPiANCg0KSSBqdXN0IHdhbnQgdG8gY2hlY2sgdG8gZ2l2ZSB5b3UgcHJvcGVyIGNyZWRp
dCBmb3IgdGhlIHBhdGNoJ3MNCmNvbnRyaWJ1dGlvbi4gU2luY2UgSGFyc2ggaXNuJ3QgdGhlIG9u
bHkgb25lIHdvcmtpbmcgb24gdGhpcyB5b3UncmUgbm90DQpzaW1wbHkgdHJhbnNwb3J0aW5nIHRo
aXMgY2hhbmdlLiBQZXJoYXBzIHlvdSBzaG91bGQgYWRkIENvLWRldmVsb3BlZC1ieQ0KdGFncy4N
Cg0KVGhhbmtzLA0KVGhpbmg=
