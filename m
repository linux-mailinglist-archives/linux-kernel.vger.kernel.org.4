Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484E3749110
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 00:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjGEWlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 18:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjGEWlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 18:41:19 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711461BCE;
        Wed,  5 Jul 2023 15:41:15 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365H3DYT017443;
        Wed, 5 Jul 2023 15:40:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=lnnAFds+s+jYb/GkfwqZxiYN1SsbC+apAUoDqHli+Ao=;
 b=LxJk3Cr0/YO/fXvN07IRnjAMVI9+xgaJw+PjceNpkfNPhp8aERZHcCVc0PL0qTz0/2hE
 3/2J+cD59IPQto2DwmkVkT3YY8BPeJSkEfEet2kxcIameYR9y5145XGkirCelG7cUvCy
 yypNtX2QLjYLdjhWA/gnXnIXoYiULeQyesy6Knl0dyJvs/8Jz05mBVCTS6XL2LGKrBDt
 NrCd/0Z95qx5UjchIYMTaHhTbey8AloMyBGjR/Xw3pnxJzDsdoCWOigkm+Ak6DQ455+M
 H+UzGnYg6RjKCYRbxQcIZJIb+7ftY7tDS3zXNzAGm8/eorOxu0AUvPIMNFbDq1DNrYXG og== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3rjkd4g1hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 15:40:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1688596847; bh=lnnAFds+s+jYb/GkfwqZxiYN1SsbC+apAUoDqHli+Ao=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=YJj1qTZ5YbKZOSaY7O58uaPcK/LqQ2dkxS2W1tXO+0lZ11Bq+pZLdSW6xZv9He1KY
         LgPSPOcUIrpPNOeBhbcoJQkZPgKi1pO+0PvS6KPwj4hQfBmX3wL0BZU0Xw8h7giHGv
         n22vKC+VoDTxl7NFD2VDSAH4l6OgVXFC//GAqXOMi2EsliOyRNXBmwlrVajP+4c6K9
         /+Ietwkh8CWegCbRHJmpWaYRrQcn265AMRzLbrGi02iwH0zQX9imsqBZZ2djjJeqba
         fVUB9+HiTIU6cZfAGTYubHvr3WnTMspsCPOsdJL3MjaWsBLudHuCu3OU7Kh4ZZs00v
         MV5mzziidJTWg==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7AA22401D0;
        Wed,  5 Jul 2023 22:40:46 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E7E50A0080;
        Wed,  5 Jul 2023 22:40:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=IAcdvd15;
        dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 465BF401FA;
        Wed,  5 Jul 2023 22:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3F7TZBSUEtsIXOoniebgMOXCuyt5S8fbg7Lx+32Mf7vueMTlS02acqhi9JuIQh/epEO+eCof5JgwYEbFOM9lNcMmbZcUXb5I2C0rV2VSbGXOi/HyQnIg476EMpAy/EVn5EbDWlM9p+KJxjNU17l20fj2Xgjg/n6XIIIofBBjsEQN+ea2XwMJKWLAvaBQM5bHOEFTcPNzG6dOVBUHHTs0KYA0+G30GlGG9hKAQ17Wu5lzXVYRWhOIUIbu406Rn7GC+Ri68PwrEcsOTtNG93JKBXziWoDlqOQVlptGZ2BERW+/IyDlTQeETrohS2TpZ1WMmYbd3W2K+u7LUugrUhY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnnAFds+s+jYb/GkfwqZxiYN1SsbC+apAUoDqHli+Ao=;
 b=jyAMGro4krAKBnNwFByyPrrxW8nUW07iGB2cBk5zLSNEaeZICM+9bOaDZ8QWtz+LPOgrSnguW5AEwYR/4zLEngh5jZQCnLc2oDqGFYLQj4RtL0ZTpOcWb7iagakwns4TyDUSJkzU/W6HS4yZbOHyq4L/NG66vDesYXEielyg1M59PPcxAGwnGrLUsYmDflTrLj5ZIOf8FLGfNc2jH42ViEuBBI1Zp5Nhj7otFrxbhE12R0wzfzPXyk1tcduNRcfhLAssuid5VyHwhB0hprAFVaIgJLwNc31vjtjLMRCrBZQb2GPn2J/4tcoos6eD0PrhXL5rbliaHvktmCzFIZ11MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnnAFds+s+jYb/GkfwqZxiYN1SsbC+apAUoDqHli+Ao=;
 b=IAcdvd15nctJnKppGS3jXo3hFLoNXkoDGzhqy4wHiUthfobqvbBotqvqRpVtdE2Lpqj2Zky0DkTHfPovPRA5C6nPW6nh2IDnCmY8tl97ATBiHi4r4FUGra7XlD9JiJidIlxDz7GUCeD0WQnboXt28VBt4aNOz13m0bUNOFlqBfQ=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 22:40:36 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b%3]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 22:40:36 +0000
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
        Johan Hovold <johan@kernel.org>,
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
Subject: Re: [PATCH v9 04/10] usb: dwc3: core: Skip setting event buffers for
 host only controllers
Thread-Topic: [PATCH v9 04/10] usb: dwc3: core: Skip setting event buffers for
 host only controllers
Thread-Index: AQHZo/oUWyyJ3lQGykedS+ST62GFCK+Y+/MAgACUuQCABDTaAIAAA10AgAkZ+oCABPiYAA==
Date:   Wed, 5 Jul 2023 22:40:36 +0000
Message-ID: <20230705224032.cznu2yjfqwic56dm@synopsys.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-5-quic_kriskura@quicinc.com>
 <20230623222754.auuce7y6c2e7ymvw@synopsys.com>
 <19932a93-4fc8-f177-8cd6-b6ecd5e163c2@quicinc.com>
 <20230626233424.2flncnsvfzb2ccbt@synopsys.com>
 <20230626234626.aqhaluh6wnat6gxx@synopsys.com>
 <9e4ad4b4-60a5-77ec-02ed-183079696e0c@quicinc.com>
In-Reply-To: <9e4ad4b4-60a5-77ec-02ed-183079696e0c@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB5120:EE_
x-ms-office365-filtering-correlation-id: 182e6b1b-55bd-4b5b-cbe7-08db7da8d9ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fjC4oY6N9SdSg9nqhsEX4p11XZL9Z6TqkqVd+JQOpGmfmCcQb4xWn+TumQeSJX7mIDjXklCMMGDK+qOTubNm8w3sztg7ZTKnmfGFSqVzwztMbnA6PPwSevIwZTjVwbpKJqxZE7yCnMUoaTMv8NjgswBeHm5shA9yNfGPGl0PMKkBwjr7FgCe/36RWpqiP7Bp6GnvzIEPQg/L4Q/GVQnvx/Duxegy9f2kpXVMK80M/3/BPIJU+TTQVoeOk348F+49iFwx6Hn9pgJg4UO3mDg2+5vPPhaMNJIypfHcbTs9jVEDNcGP0JynCQzzzSsjvdu0yuLr0WnzB2ASOACIDxG6w93E8askzT1c51/Y84/JN4IkREPukpKxncohQmMjcek02bLCQNEu/7WB6e+9wXQJgAkkOSB+IG9egONJwUPEXt+QNbwIDKCQm1Fv4aq6A72D0YGu+934Q0e+yKMRL76xfQXu2yzBJoiLFclqa2MGbeOV3ftEuFQQMnVzhwSjdai62RqCq3LSBzxOY82O4MNgrUKFD/efQBS7ITKxeP9M8Y1MkrmQvuuodn3yKgsVv6d6F/pC3PxxWzp42ZI/Xvh0U+laGlDErq/H8MktcLbMWsLKdaNSiGek/wgv4MBOQUU/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(91956017)(66556008)(54906003)(66946007)(6486002)(122000001)(71200400001)(8936002)(478600001)(8676002)(41300700001)(4326008)(66446008)(64756008)(38100700002)(76116006)(6916009)(2616005)(316002)(66476007)(186003)(83380400001)(6512007)(53546011)(26005)(1076003)(6506007)(86362001)(5660300002)(38070700005)(2906002)(7416002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGFOL21xUFRJdUtCRjhndjRTV1lSZzhGcE9VaFQxeVFabWVUYUtpZkdXZFI1?=
 =?utf-8?B?MTI3WnMwcUFGUXhUWlJaZWNNS3ZMNm80aktTckQ2bTJuSW1rSlc3a3c1dktH?=
 =?utf-8?B?MCtud1ZMZDdhVjFkVWlMc2JKL0w1azEwWnUwTlF0ME1iblBPQnBCQzZTYzdo?=
 =?utf-8?B?VlRmZDhFR1dKMHdFNUFQT0g0dHJ5Z3RtQWR3QUV5RUtiK0xSeUEzT2x6TGZM?=
 =?utf-8?B?YjZkT2JDcFdoL3Jjbm1KaG1abXM3ZmVNVG42dEdqMzBIMjRmOTNNZkk4RW9k?=
 =?utf-8?B?WHVOc3RySC8rVHFESkhONzA0YWU4TWI4Vm9kT1Jlc3lHTHNBOE9LUDB0SlZw?=
 =?utf-8?B?RlQvdzRDMDJGUjNhUjBhb1JhNlVWazJFd3crMFhzNHVBRkpSOWI5SG5CUWV1?=
 =?utf-8?B?RWprVXZXcTkvRlRxR1ZicnQxSkJYMS9OTkJqMWt1QXBHaEJvbTNUWldtREV4?=
 =?utf-8?B?aStMOWltNGFpR3M2ako3VVpvK2pvc0RlYU02dS9IY0dKUWErUGYrRi94OUpz?=
 =?utf-8?B?MXQxOEMwVnJvMDYwUXpVWHBGRTFCYmdhUDg0bXpYRWZUOE1aeDVGM0RBcnVV?=
 =?utf-8?B?akRpWVVYWHRsRW5sdldUZkMxS0E1RDhacEFTQXdndEZJMUl4eWd6aUZ4ZEF0?=
 =?utf-8?B?T3B3LzdCY1hNdnhqUm5ReEcrbVQyVm1OcklocnZxQTNTWERJTzFSRTdOOURn?=
 =?utf-8?B?NGNXTEFvems4Z1RFbjdOMlNTL25pQXJCZ0NrRTBKWUx4L2xUeFlVNXY2OVdr?=
 =?utf-8?B?cnVORXVqcGF1QStHS09zV2dBQ0ZlRmpsNEtJL1JTQU5XNFRiY0FjVTZ6WXJl?=
 =?utf-8?B?YTR6Unc0ZFo4bnhobGFsZlFVR0J2c0F6NE8yZ3BwSndMd2Z0MkhjeGJmR0ZO?=
 =?utf-8?B?QkdzODBDRFpSY3o3SFVBbmlEWDJadGRRdVhncWxmc3lTc0xUcWNyNi92Z054?=
 =?utf-8?B?NmVjQ0YxK0NScWJhV1BBcHA2VDNKSVBkS21RREdYMnBsa3NIR01OdWo1aXVT?=
 =?utf-8?B?SFpKUmFDTjJYSEJweG9MS2xYa0JGdU8rL1EyZ1dpbWxjbzFwTWw4b2lNSGJE?=
 =?utf-8?B?R1UybFYvWFY2ODROTkxFdWZjVjhEMkU4SVg2dWlEK0VqRVBpV0UvekJUZHNr?=
 =?utf-8?B?YXZFcm5EbWdRVS9VRit0UTdjZ0o3TFcybEtEcDYvenZGQ0JZMGd4YXBBYTEz?=
 =?utf-8?B?OTVWbTZhOUdKSnNPaHJwUW5UUzRQT3NpMHMrRCs4TTl5eFFnb3ZML3BWWFJs?=
 =?utf-8?B?RXprSmg2S3dicDZRU1lhSkV3OTBvUzhpeUZZZWNzTlBuK3BteUxUeFVGcHFh?=
 =?utf-8?B?L0VobWtjaVJqdkR4cXhWYk8yNE45WGlPREtlSFBPa3Y3d1FPM1ZVbzFaTXg2?=
 =?utf-8?B?RVNJK2JDUjIxWXV5Tyt2YVRjUHBSNUk1SEhZVkY3UFF1UHhUTTVyaGova1Qv?=
 =?utf-8?B?VmFBQXkrN1JHMTR5QzJOd21HeGsyV2Mzd3pyYzFlbXo2TlRCWGVkMG04OGhF?=
 =?utf-8?B?SDRwb3VtUlUxRmpkRlBJUDM0UC9wSHVZQ09CL2p4WXYreTNtRndBb3U1bU8x?=
 =?utf-8?B?Z09iOHNlc1dQcU1PZDJVQ2ZqWVpDKzE5RzJNOTFCakJVRlVrMUFYeXkxT0Fo?=
 =?utf-8?B?bGZZNlpHQWlYTlJ6YzVvanJCdEdrVTRHYUs3bjh6YTliYXEwVHF1d2daWlVU?=
 =?utf-8?B?OXhvWFZ1K1l0Yjg2OU1yZGFrV3h6K0F3aUpCd2gxSHFteXZRZ2g5QzBsVVp6?=
 =?utf-8?B?a0NOa0o0bzIxc2hyaURLYW0zU0hKeHJSY0o3NmQ1RDlSbklmeFRadGJla2g0?=
 =?utf-8?B?MlZleitGUnFHa2xxOXQ3R3VaYnplMC9RdG5OdjIwRjhKQStWNU9tcm1CM2hn?=
 =?utf-8?B?aEwyUFcrQkxkVkNlckZ2djZQR241dEtZYTBTYS9peVN1RFBoOGdZbnZGTmx6?=
 =?utf-8?B?Wk54eDM5OWEzbi8wUFlVT1dpcE5LTzJNTzhPSGs5N1VldEsweDlkT2xRQmdt?=
 =?utf-8?B?SDhxRUlja05LRzBWVytRT3FBcmNlSU03MWpidzVXNEVhdSt4UjdZdGc5RTdZ?=
 =?utf-8?B?enlCRkNKZUtxRlA2M0VsSzFzS0l1OHYxU1FqZU9RaG90MENHR3pHdXhUTit5?=
 =?utf-8?Q?VdSdULeo9/6dmjPWnNzSZZiqq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E01BC54F92DFD4484A0C38AD6F6D1B5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SmNhZnpSd3RlLzVNa3hBbHlLeFFNMmJiakpGTXRUVXVzOGcvbWxiTlpuT1NM?=
 =?utf-8?B?Q1Z3R1U5Ukc2K1pIMExlbHE3QmNiNWxZdHZ2dE4yOFE1MnB3L2xPdGRWbHNU?=
 =?utf-8?B?M2J1NzY3MENaMFQ3S3o0cHF2ejZoWlI0b0h3Q3pCbW9tR1ppZmoxUFRxc2pl?=
 =?utf-8?B?aThKblAwSVNzZUtrRUZNdWdyVmFpMmgxRnBtR3UxdEZtY3JWWUJlZ3lqTnUv?=
 =?utf-8?B?SUNrdEZGVlNLaVhQSFp6WDVxaWwwWnVxTXBjcS9xMUxLeStxUEcxeEthY2xj?=
 =?utf-8?B?VEpXcmxIUTZHaGNKYzdjaUtpNmdyRlNYUkI4V21KUlh4ZVVxNm9nWG94N2pp?=
 =?utf-8?B?WDBZb0VxSHJHa28weWwrcEFXREhNb3BGcXl4WFRxaVhra05UVHJ4c3puOERW?=
 =?utf-8?B?MU5CMElpNHMyOWZUTGxRQmxnUWpvdG8raHFEOFRETWpXUWI3TXBoWnNuMzBz?=
 =?utf-8?B?SDZqaFYvNkhndXZ6SFVpSWtnT1NvSUtadnN1bjVlbjROKzBCTWk1MlhNcW1N?=
 =?utf-8?B?ZGRRdUNjSGhHOHNrSEtIRlcwMys4d2NVY0xQUkJOeWZpL0ZHc1N4Q3d5NGND?=
 =?utf-8?B?c24zOHZ2eDhGU0gzZnJrc3ZLUUY1QkI1azYrVzBnbytodXIxN21pOEFaTk12?=
 =?utf-8?B?SFgzM1p2UEs1SnlCbm1sZ3RhSFFrZGpZdGdDZTE0UXdndmhhVUZ0N3hUNjI5?=
 =?utf-8?B?TWhSdU45cU5OYndaWmNlR2hORU8wR0d2Qzg0WEloRHliZHltbmFuUEFzWDZT?=
 =?utf-8?B?MFlNYysvN1A0YUxUOWNIS2NCQjFNWkUveDJtU20ycEMzNHVuTW5FSzlld0g3?=
 =?utf-8?B?dUZvNHA1MU01cDhVQVJBb3YxSFo3NjZ6Z3ZXb2NGVjJXU0FpaEJhREpCazJ4?=
 =?utf-8?B?bkpqaDBrVXl5cnBOck5jcGU4M2ZGRWVQUWxqSnRrL3c4dkRVYkgxOHY3QVBB?=
 =?utf-8?B?NVUrdWZva2txcXM5aUI1RW8rOVpQclFydUt4OFBxMk5OWGw3dkpKODcrT0xq?=
 =?utf-8?B?V1RDb25NSEl6c1diZ0ZHTllkYVM5eThsejhudlRJeWg2aEt4YlVBbXpDWkJQ?=
 =?utf-8?B?L0ZHT29BQlZBcUJJM1gyT1I5UjJxQ015S0ZHOGlvbDk0cnQ5YnJDWTBnRnVh?=
 =?utf-8?B?aUdoR3RXNEtWRG1UQkQ3ckFPaHZYemdnMTBZcFcwQnM4aWZHR3BXY3RqRG9W?=
 =?utf-8?B?ekhwRzZScFJaRjBZbi9yYnZ4Y3VhSnNhb0tFUVBoU1oxL0lIU0VZb3R5Njh1?=
 =?utf-8?B?ak5YaExHRjRxU3owcUtGZkJtaytUdURZUlk3YUltVStOVHJTN2I5eVFIM2Rn?=
 =?utf-8?B?dUNvN2psaDR2RXZZMVdBYVdwNDVqMjdrdEs5ZDNHZXBFT1ZlT08vdHIzTW9L?=
 =?utf-8?B?ZGU5Mk54WGh4WlE9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 182e6b1b-55bd-4b5b-cbe7-08db7da8d9ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 22:40:36.6880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6LnT8hl/gl4+ZIQ6c/ckdXaLoexSz5MsOnM7gkL4KA2N4d1G6ZgSB/95WNOjqiEv0c5t0adSd55D0hNP+QodrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
X-Proofpoint-GUID: sef8dOOEQaT8BE1NcfQymvcf6BPDvBen
X-Proofpoint-ORIG-GUID: sef8dOOEQaT8BE1NcfQymvcf6BPDvBen
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307050204
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKdWwgMDMsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNi8yNy8yMDIzIDU6MTYgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBN
b24sIEp1biAyNiwgMjAyMywgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gT24gU2F0LCBKdW4g
MjQsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4g
PiANCj4gPiA+ID4gT24gNi8yNC8yMDIzIDM6NTcgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4g
PiA+ID4gPiBPbiBXZWQsIEp1biAyMSwgMjAyMywgS3Jpc2huYSBLdXJhcGF0aSB3cm90ZToNCj4g
PiA+ID4gPiA+IE9uIHNvbWUgU29DJ3MgbGlrZSBTQTgyOTVQIHdoZXJlIHRoZSB0ZXJ0aWFyeSBj
b250cm9sbGVyIGlzIGhvc3Qtb25seQ0KPiA+ID4gPiA+ID4gY2FwYWJsZSwgR0VWVEFERFJISS9M
TywgR0VWVFNJWiwgR0VWVENPVU5UIHJlZ2lzdGVycyBhcmUgbm90IGFjY2Vzc2libGUuDQo+ID4g
PiA+ID4gPiBUcnlpbmcgdG8gYWNjZXNzIHRoZW0gbGVhZHMgdG8gYSBjcmFzaC4NCj4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gRm9yIERSRC9QZXJpcGhlcmFsIHN1cHBvcnRlZCBjb250cm9sbGVy
cywgZXZlbnQgYnVmZmVyIHNldHVwIGlzIGRvbmUNCj4gPiA+ID4gPiA+IGFnYWluIGluIGdhZGdl
dF9wdWxsdXAuIFNraXAgc2V0dXAgb3IgY2xlYW51cCBvZiBldmVudCBidWZmZXJzIGlmDQo+ID4g
PiA+ID4gPiBjb250cm9sbGVyIGlzIGhvc3Qtb25seSBjYXBhYmxlLg0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiBTdWdnZXN0ZWQtYnk6IEpvaGFuIEhvdm9sZCA8am9oYW5Aa2VybmVsLm9yZz4N
Cj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1
cmFAcXVpY2luYy5jb20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICAgIGRyaXZlcnMv
dXNiL2R3YzMvY29yZS5jIHwgMTEgKysrKysrKysrKysNCj4gPiA+ID4gPiA+ICAgIDEgZmlsZSBj
aGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5j
DQo+ID4gPiA+ID4gPiBpbmRleCAzMmVjMDVmYzI0MmIuLmUxZWJhZTU0NDU0ZiAxMDA2NDQNCj4g
PiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiA+ID4gPiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gPiA+ID4gQEAgLTQ4Niw2ICs0ODYsMTEg
QEAgc3RhdGljIHZvaWQgZHdjM19mcmVlX2V2ZW50X2J1ZmZlcnMoc3RydWN0IGR3YzMgKmR3YykN
Cj4gPiA+ID4gPiA+ICAgIHN0YXRpYyBpbnQgZHdjM19hbGxvY19ldmVudF9idWZmZXJzKHN0cnVj
dCBkd2MzICpkd2MsIHVuc2lnbmVkIGludCBsZW5ndGgpDQo+ID4gPiA+ID4gPiAgICB7DQo+ID4g
PiA+ID4gPiAgICAJc3RydWN0IGR3YzNfZXZlbnRfYnVmZmVyICpldnQ7DQo+ID4gPiA+ID4gPiAr
CXVuc2lnbmVkIGludCBod19tb2RlOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKwlod19t
b2RlID0gRFdDM19HSFdQQVJBTVMwX01PREUoZHdjLT5od3BhcmFtcy5od3BhcmFtczApOw0KPiA+
ID4gPiA+ID4gKwlpZiAoaHdfbW9kZSA9PSBEV0MzX0dIV1BBUkFNUzBfTU9ERV9IT1NUKQ0KPiA+
ID4gPiA+ID4gKwkJcmV0dXJuIDA7DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhpcyBpcyBhIGxp
dHRsZSBhd2t3YXJkLiBSZXR1cm5pbmcgMCBoZXJlIGluZGljYXRlcyB0aGF0IHRoaXMgZnVuY3Rp
b24NCj4gPiA+ID4gPiB3YXMgc3VjY2Vzc2Z1bCwgYW5kIHRoZSBldmVudCBidWZmZXJzIHdlcmUg
YWxsb2NhdGVkIGJhc2VkIG9uIHRoZQ0KPiA+ID4gPiA+IGZ1bmN0aW9uIG5hbWUuIERvIHRoaXMg
Y2hlY2sgb3V0c2lkZSBvZiBkd2MzX2FsbG9jX29uZV9ldmVudF9idWZmZXIoKQ0KPiA+ID4gPiA+
IGFuZCBzcGVjaWZpY2FsbHkgc2V0IGR3Yy0+ZXZfYnVmID0gTlVMTCBpZiB0aGF0J3MgdGhlIGNh
c2UuDQo+ID4gPiA+ID4gDQo+ID4gPiA+IEhpIFRoaW5oLA0KPiA+ID4gPiANCj4gPiA+ID4gICAg
QXBvbG9naWVzLCBJIGRpZG4ndCB1bmRlcnN0YW5kIHRoZSBjb21tZW50IHByb3Blcmx5Lg0KPiA+
ID4gPiANCj4gPiA+ID4gICAgSSB0aG91Z2h0IHdlIHdlcmUgc3VwcG9zZWQgdG8gcmV0dXJuIDAg
aGVyZSBpZiB3ZSBmdWxmaWxsIHRoZSBnb2FsIG9mIHRoaXMNCj4gPiA+ID4gZnVuY3Rpb24gKGFs
bG9jYXRlIGlmIHdlIGFyZSBkcmQvZ2FkZ2V0IGFuZCBkb24ndCBhbGxvY2F0ZSBpZiB3ZSBhcmUg
aG9zdA0KPiA+ID4gPiBtb2RlIG9ubHkpLg0KPiA+ID4gDQo+ID4gPiBUaGUgbmFtZSBvZiB0aGUg
ZnVuY3Rpb24gaW1wbGllcyB0aGF0IGl0IHJldHVybnMgMCBpZiBpdCBhbGxvY2F0ZWQgdGhlDQo+
ID4gPiBldmVudCBidWZmZXIuIElmIHRoZXJlIGFyZSBtdWx0aXBsZSBjb25kaXRpb25zIHRvIHRo
ZSBmdW5jdGlvbiByZXR1cm5pbmcNCj4gPiA+IDAgaGVyZSwgdGhlbiB3ZSBzaG91bGQgZG9jdW1l
bnQgaXQuDQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ICAgIElmIHdlIHJldHVybiBhIG5vbiB6
ZXJvIGVycm9yIGhlcmUsIHByb2JlIHdvdWxkIGZhaWwgYXMgdGhpcyBjYWxsIHdpbGwgYmUNCj4g
PiA+ID4gZG9uZSBvbmx5IGZvciBob3N0IG9ubHkgY29udHJvbGxlcnMgZHVyaW5nIHByb2JlIGFu
ZCBub3doZXJlIGVsc2UuDQo+ID4gPiA+IA0KPiA+ID4gPiAgICBBcmUgeW91IHN1Z2dlc3Rpbmcg
d2UgbW92ZSB0aGlzIGNoZWNrIHRvIGR3YzNfYWxsb2Nfb25lX2V2ZW50X2J1ZmZlciBjYWxsDQo+
ID4gPiA+ID8NCj4gPiA+ID4gDQo+ID4gPiA+IFJlZ2FyZHMsDQo+ID4gPiA+IEtyaXNobmEsDQo+
ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBJJ20gc3VnZ2VzdGluZyB0byBtb3ZlIHRoZSBjaGVjayB0
byB0aGUgY2FsbGVyIG9mDQo+ID4gPiBkd2MzX2FsbG9jX29uZV9ldmVudF9idWZmZXIoKS4gU29t
ZXRoaW5nIGxpa2UgdGhpcyBzbyB0aGF0IGl0J3MNCj4gPiA+IHNlbGYtZG9jdW1lbnRlZDoNCj4g
PiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+IGluZGV4IDBiZWFhYjkzMmU3ZC4uYmJhODI3OTJiZjZm
IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+ICsrKyBi
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiBAQCAtMTc3Myw2ICsxNzczLDcgQEAgc3Rh
dGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gPiAg
IAlzdHJ1Y3QgcmVzb3VyY2UJCSpyZXMsIGR3Y19yZXM7DQo+ID4gPiAgIAl2b2lkIF9faW9tZW0J
CSpyZWdzOw0KPiA+ID4gICAJc3RydWN0IGR3YzMJCSpkd2M7DQo+ID4gPiArCXVuc2lnbmVkIGlu
dAkJaHdfbW9kZTsNCj4gPiA+ICAgCWludAkJCXJldDsNCj4gPiA+ICAgCWR3YyA9IGRldm1fa3ph
bGxvYyhkZXYsIHNpemVvZigqZHdjKSwgR0ZQX0tFUk5FTCk7DQo+ID4gPiBAQCAtMTg1NCwxMSAr
MTg1NSwxNiBAQCBzdGF0aWMgaW50IGR3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gPiA+ICAgCXBtX3J1bnRpbWVfZm9yYmlkKGRldik7DQo+ID4gPiAtCXJldCA9IGR3
YzNfYWxsb2NfZXZlbnRfYnVmZmVycyhkd2MsIERXQzNfRVZFTlRfQlVGRkVSU19TSVpFKTsNCj4g
PiA+IC0JaWYgKHJldCkgew0KPiA+ID4gLQkJZGV2X2Vycihkd2MtPmRldiwgImZhaWxlZCB0byBh
bGxvY2F0ZSBldmVudCBidWZmZXJzXG4iKTsNCj4gPiA+IC0JCXJldCA9IC1FTk9NRU07DQo+ID4g
PiAtCQlnb3RvIGVycl9hbGxvd19ycG07DQo+ID4gPiArCWh3X21vZGUgPSBEV0MzX0dIV1BBUkFN
UzBfTU9ERShkd2MtPmh3cGFyYW1zLmh3cGFyYW1zMCk7DQo+ID4gPiArCWlmIChod19tb2RlID09
IERXQzNfR0hXUEFSQU1TMF9NT0RFX0hPU1QpIHsNCj4gPiA+ICsJCWR3Yy0+ZXZfYnVmID0gTlVM
TDsNCj4gPiA+ICsJfSBlbHNlIHsNCj4gPiA+ICsJCXJldCA9IGR3YzNfYWxsb2NfZXZlbnRfYnVm
ZmVycyhkd2MsIERXQzNfRVZFTlRfQlVGRkVSU19TSVpFKTsNCj4gPiA+ICsJCWlmIChyZXQpIHsN
Cj4gPiA+ICsJCQlkZXZfZXJyKGR3Yy0+ZGV2LCAiZmFpbGVkIHRvIGFsbG9jYXRlIGV2ZW50IGJ1
ZmZlcnNcbiIpOw0KPiA+ID4gKwkJCXJldCA9IC1FTk9NRU07DQo+ID4gPiArCQkJZ290byBlcnJf
YWxsb3dfcnBtOw0KPiA+ID4gKwkJfQ0KPiA+ID4gICAJfQ0KPiA+ID4gICAJZHdjLT5lZGV2ID0g
ZHdjM19nZXRfZXh0Y29uKGR3Yyk7DQo+ID4gPiANCj4gPiANCj4gPiBBY3R1YWxseSwgcGxlYXNl
IGlnbm9yZS4gdGhlcmUncyBhbHJlYWR5IGEgZG9jdW1lbnQgdGhlcmUsIEkgbWlzc2VkIHRoYXQN
Cj4gPiBmb3Igc29tZSByZWFzb24uIFdoYXQgeW91IGRpZCBpcyBmaW5lLiBUaG91Z2gsIEkgZG9u
J3Qgc2VlIHRoZSBjb25kaXRpb24NCj4gPiBmb3IgZXZfYnVmID0gTlVMTCBhbnl3aGVyZS4gQ2Fu
IHlvdSBhZGQgdGhhdCBmb3IgY2xhcml0eT8NCj4gPiANCj4gPiBUaGFua3MsDQo+ID4gVGhpbmgN
Cj4gDQo+IEhpIFRoaW5oLA0KPiANCj4gIERpZCB5b3UgbWVhbiBhZGRpbmcgImR3Yy0+ZXZfYnVm
ID0gTlVMTCIgc3BlY2lmaWNhbGx5ID8NCj4gDQoNClllcywgcGxlYXNlIGluaXRpYWxpemUgZHdj
LT5ldl9idWYgdG8gTlVMTCBzb21ld2hlcmUgaWYgaXQncyBob3N0IG1vZGUuDQoNClRoYW5rcywN
ClRoaW5o
