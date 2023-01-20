Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CBF67487D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjATBDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjATBDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:03:09 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFFEA1028;
        Thu, 19 Jan 2023 17:03:07 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JJv3La011397;
        Thu, 19 Jan 2023 17:02:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=TVYYmJfWfZ4bSz8ez2cosdhy45KljTOSr7jZ/KNMvPk=;
 b=kQsGqeqa7ZFXoAmO3ScfmacKNcOvdfZ3yy7VEnihkiWGTHFuiqohM86iiKiQgoVaW4SB
 7R9zqIKrmWBzUbzwlaoMsoYeP84g0Htz/AuGilJ+LXP28Fse7D6Bx6h/2H9ZvG+XWWL4
 OoSyfkqHAEETe8iau6OlDHVonTilsRI+pwY7+dcLY8Fm31q4+iu4REBneseCTaEUWwDY
 tizRcgylh4PYoz0HxkM/CePL2jGAOj41OPaNZY+5Z4BQKIcmucOk/qyUNmGVcx0SD1Ly
 GFnKGNvtBakmFk5JlxYbiG4BrDj8osnn2dhGcmLjaBfanBzMZT2y3yS3bY7rVqxzWI5N YQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3n78wv37ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 17:02:48 -0800
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 40613C098D;
        Fri, 20 Jan 2023 01:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674176567; bh=TVYYmJfWfZ4bSz8ez2cosdhy45KljTOSr7jZ/KNMvPk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LsuZMCbf/xWKLGLGI/C3VjOU9UYGRVoF2kCbaL4XfbRRLBMQZo9MefEbTM7aaNfTF
         2Z3dR/fashJPbHgeqF1VCFTiDL4mcledtJMsnd8l7HooXvFaAYvAKjJ8jxKTy4nc1K
         qbEBxqVCPzb79d7Zym0fIxDtVX6uKCopDg4+PqJWN1P4lPXbTS7r7scUzmBYXMwyvt
         u+zqbLvIKONsIhfiFs8x35yRedMAHVvjL1Dt++a98Mk7WXGEmbSp/swgO1YwM6wHc/
         rvlVcJ09bkDAl7pkkmna4b5WxR5R9m6F7gH3GBRX9f5YTk+MgvL4s/VPqSGYfrph1/
         kj68o6OLUfL3g==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5001DA00BC;
        Fri, 20 Jan 2023 01:02:44 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9244440139;
        Fri, 20 Jan 2023 01:02:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="U+5wJy6y";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AS9lpqtRSw/qx+3C9xzvBDPKqabAYIZGTkuHe/d7vQY01nkcWAh0rOJWCTKBr+9ivQVLvNNaSWJuZwNT9ha639gdPVWWrbuk4Y7uzU0siU+5Dk83/hZ+ymSQJ1NqAZsXUitvkdKnfWF7HxuvO9Y8FYrLZ2sctrdxW56i02DxROxr8JFFT1ugmLlQsF7HLKqhVBZOPlknP8GFBk09VRnS0RSZ++rAHBd5ZpcbGkCgeGhmwEJH8Mj/U/3c/qOVHxqfR6KHo5uTrlvFmfY7ssaX2YDJllCOdx4f4HU8mdh46x4g4DheIpwAmAoEiUTsSpXeun9Io1fF/ssZR2xKewgoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVYYmJfWfZ4bSz8ez2cosdhy45KljTOSr7jZ/KNMvPk=;
 b=OH1Sbrq9+zAcIRqjdftwzEB2Pvo28n9wjVWaWCfUz1lRBOXTQvPMYi9BavNeqcP8XGr+K7YhwySAlYYAR13LTgZ+9OjvdvHFVcqmsJl8kATM6j+R7aM3Cn0eeG9iQp3TuIZicece9WcuYC/lhvIVGWtmMOdOcpG6UbM/v7sDwrkeJvsM17EDCyG8PwhS76BVr5ET2x/Z7qPnwc97WhC6MzgdMP/Y7x9fbmUgsohsJ3Piw/W6w4dVO7IQ8fDTOOcxzaS/2ZG28dlX7xJfa98oSpSAgsSRJe6KOVjPBjVDUucKR31OB4P/PeBzDsxvjdORwmyKcp8p/r/pyzBUpBRgZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVYYmJfWfZ4bSz8ez2cosdhy45KljTOSr7jZ/KNMvPk=;
 b=U+5wJy6yV6EIvQkLzC88Xhyq7DhpU56A4newnnU8SfWU/nW4CHcoAeKfR7VfKpQRHSczECwuC8lvsPjpZE+Tm0kcfYGehDKw2PzRi50W8qL7/bZIsUpFP2W23mOhZ9cIPrwaTI/cd33mEfvGNIeuNwW2pju2Q7ojycspPqCdIAQ=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 20 Jan
 2023 01:02:39 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee%4]) with mapi id 15.20.5986.018; Fri, 20 Jan 2023
 01:02:39 +0000
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
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>
Subject: Re: [RFC v4 2/5] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Topic: [RFC v4 2/5] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Index: AQHZKNZ01nzPNqP4IUaLkP7OVwXfx66k6muAgAAojICAAXEUAA==
Date:   Fri, 20 Jan 2023 01:02:38 +0000
Message-ID: <20230120010226.wjwtisj4id6frirl@synopsys.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
 <20230115114146.12628-3-quic_kriskura@quicinc.com>
 <20230119003619.ane3weigd4ebsta6@synopsys.com>
 <7fa2d7b0-509d-ae90-4208-6f0245f927f7@quicinc.com>
In-Reply-To: <7fa2d7b0-509d-ae90-4208-6f0245f927f7@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN6PR12MB8514:EE_
x-ms-office365-filtering-correlation-id: 5a7b164f-a281-412b-e894-08dafa82064b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: koukMYsw1TflduPgpwyiwuzxDOKUdUmyDWwr+A2WaebmjyQZCAg4+XbOwgNjvRDkge7QjcpmY+EvVO/Gn+SScRxZY2XW1P4woxaDvubP+YhDguLAbbjbQJgGKzxpKzSO7V5FUlgO2FIKzKHMltke0WbhFWfWlya9yQQp+lP/Miusdo7T57jAcLhAeIGT9/OH4EZiJ8KfB0V0Uh7Cjn3FE+Z+k05WgzWPfFaTvpBoldsvFRmVdZ8b/O3V8XzRnZxRb3D4tHvNxdG55t8sC1aj9/pz0Mv55NdGYI5L6wuWS/AMyn0+PH2xz4YqlyU1cZFXcV83TmI+HJmT/UN4EhHjN1LUzvZYOtXPSMJclwftVov818cxF3A5SXLOy5MfLOr58Hyljy6Bid54gEk1TGuGdHe1mdMMAn8FqPxAmAaQSNjAbz9J4HX5oHojGB6GOs0X4tlQ/t50KSSqxX/B4LfkgwIgf42M92VJC9tyQ/UxkomUabvlhpIuOAnM5MWyHQ9IhIYRI7+3aWStJrN7d3y/aQ8iGTv5bk4z782BzkcXXZlgNX+Qk3FKV9ocuZh+j5odZ6cjIPRWpwa8o8w+5gRhDxJfEST27wfHG7hHF7r/GTe0wmA0VeLQ6o3AZMFaVfTQ15HRydo3OknFnlowYGS5Tk0mL7BebRmo45NCtAHMtdj/1cco7A/ahFB+elpqiQhvngmzn8t9N0BBMo5oUPrPAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199015)(66556008)(1076003)(64756008)(66476007)(41300700001)(76116006)(36756003)(66446008)(2616005)(316002)(4326008)(83380400001)(38100700002)(5660300002)(86362001)(38070700005)(8936002)(122000001)(54906003)(8676002)(7416002)(66946007)(71200400001)(2906002)(6506007)(6916009)(53546011)(6486002)(26005)(478600001)(186003)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGJhODV0ekg5Nm9lMjdCTGJObGd0V3d1enBMZzJhZlFSaXpDSDdvdDlkV3Ju?=
 =?utf-8?B?SHRFMTVVSTdJZ2tRUmFFWG9iZ3VSWjM5NThoUUVYeTJyK0hiMzZ6RTZVYXVG?=
 =?utf-8?B?c3E4WjZZYWt4QUxoZ0tUbDhSVzlwNHVkdzVnb3RsNkNCcEVjOHBlWmJhenNs?=
 =?utf-8?B?eVZuUEJncyttdG9VeW5uanVLMTB2T2Z2R1Vyb1BIVGg4RFhIVlhvVmxWNWc5?=
 =?utf-8?B?YUllSU1Pd20rY2E3MGt2SGZMeVAzWWpUUUJWUXlYa2dMd01PeE8vR0lhZ0FL?=
 =?utf-8?B?ZUtKeHBUUWlvMmJJc28yeXBuR1dSQ1h4b1ozc3lCRlZmZHNwNWxCWGxORzdx?=
 =?utf-8?B?ck1NOEVoYjkxR3lESGZOVlFBTDVSSHYwZk1VdExsNWJCMVB5QmFIY2c2VktC?=
 =?utf-8?B?dzY0NE5qRGs3ZTg2MzZSSjlCSndjVzB5VEN4TkpyNGtteHNLZ1praUh5K0Iv?=
 =?utf-8?B?bjNHU0dlSnBBQi9KRWdOZmp0dmhYdks1NUY0SUFudHMxQUxXaUMxMTltM1cv?=
 =?utf-8?B?S1ZnTzFsdlJ6eEFmbTdKMHdmSS9SSFVkMG1MVUl2N0dDaXRUY3lETDBoUzVR?=
 =?utf-8?B?RGlNMTd2ekZDOFU3S1NiYmNIY3VqTXBIRnkxRTRybm5UM0pyQVhQY1hVdnZQ?=
 =?utf-8?B?WGxVQmVldnFlTGsyaEdWNFBQRFRBSTViZG1ZTFZpNGtTbE4rc1BzamlJSitG?=
 =?utf-8?B?QVBRMkVZMkFvYkV0UVJQTnVoU1FwRFhyN3NqbjVqV3IzcnU1QmJ6K1E4OW1J?=
 =?utf-8?B?bnpPeFpaS3VrcGVVbXoyUnNsQXJhZmpjNTZGdHZ6UHNrbjRVSmVvY0dPdkQ4?=
 =?utf-8?B?RHVpdHRNaVo1VENQYmVodVdxRlBpWlIyYlEvYmtXbWx5OGM2ZGQvU1Y1TGNv?=
 =?utf-8?B?ajlvK1pTakhOQ0JSb2xvVkFRRkRQTFNIcnJrNjNKc2UxUnVSUjByK2gxSXd0?=
 =?utf-8?B?S0Z0K3NYUGtycFJKQnRQcCtiMCtFUFVxWXJsRWhsUFhBREwrNWVvazc3VHFQ?=
 =?utf-8?B?bmt3QnROM256U0I0aVA5b0lNVG9JdEg1STlVeUcyWTVHNDlZU0s5K25BczNw?=
 =?utf-8?B?ME1JQU5JbUltakN5WHIzS1I4WTFkckdtYkRNN2VXSXBNay92QjV2RFZXSlJ5?=
 =?utf-8?B?ZHdpeFhtVW8rQlB4Q1RuWFVjbysyYjMweXdUY2dhanExczhIb2JIKytpYm8r?=
 =?utf-8?B?M0VxMEp0VFljdEcxT3NIYStZMEwxZG96dHdPK1ZRRkRVeSt5c2p2M0lKZit6?=
 =?utf-8?B?YU9RRVBpZkhsN3loYitRaUdGZ0dpMFZ3eXhaVGhUdTZkdjc4WUw4WE5wTFMr?=
 =?utf-8?B?TmFxOXVJY1BQdHdhRVlLcFJQMm55RlAzRk95Ry91VkcxVTY1OHgyYjQwSXN1?=
 =?utf-8?B?TGhUbGoxbzVxMC9tdXo3MEZVOTNhY2VwbU9QdTMxVXhlREI1QVVDbExmQWhv?=
 =?utf-8?B?b3VXbTB2UlE5bFhZeU9MYjZjWW85L2ptQkgyYTBBdlhIV0ZNTlgzNmUrZng1?=
 =?utf-8?B?aDZvYUtDa2djemdZL3RZOG5oUXo4Si9DOVR1Q1JjSVUybk92a2xYTnNuOWE0?=
 =?utf-8?B?REdyZHBCdC9QOEw2VmtpV0h3ek9ML05FbTZrRUhkejdGQy8vMGRGN0oyekhm?=
 =?utf-8?B?MEViUThScmVOT2toUTh1dUFyZmI2RWR5Wjk4aFBCQ1FJa3hMYUdKa2tjZTdx?=
 =?utf-8?B?cUZQdE5KTElhRzZwZkR0TTBHZFFxQmcxTkRyWGowKzNhTVJmK1EyNGJBVUx3?=
 =?utf-8?B?YVFXS3FsVlQ3eUxLaFhtRkhyVFVsZEZ1UEN6c3dGTXRHVk0rZXRuUmhOME9t?=
 =?utf-8?B?YkRBU3k5bGRmbi9QOTVlRFJyVUpUYmNnbFpiYk9ZakpwcFg1SFlGM0dSRjBn?=
 =?utf-8?B?VjZ0aDlKS2t1SWg2dWtaL3huQmdYejR0QlloaURtTktIWHF3bnkrYjZVa05E?=
 =?utf-8?B?cnAvbW50ckw5bjBpb3Y4cHpsSkxuTGdDOStpcW9Pc0VBTEJURmQ4aWEwWm1R?=
 =?utf-8?B?MW5oWnBoajFyV1VDU2JheUt2OTd6dzB1Y0hCM2NvaHJUb2ZDVU9HN0FkTGZq?=
 =?utf-8?B?eWVzMTc2TGI1S1hWZ0hoblZZeERyRUo3aE9aNkZ4MnFESmxrZkJha2tlTVlP?=
 =?utf-8?B?NG8wMUhlL1VMRzZuZHFlMzJValJ6bDk5NVVhQk11YUhNVXdXNGpkaVFJU2dp?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5007446A5194A7488C3C5979A146C486@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dTZYOVlaRjhJT1A3ckdDb3N1VVRZMEdzdmdGY2FYY0oyUVlMNUdtMVBGTjcy?=
 =?utf-8?B?TU1ZUkNvRTNkMm1IY3FZTVpmZ1RicUVVdlZpRVdud3BxUC83V29ySlNMaDBZ?=
 =?utf-8?B?Q0pyWXJKVkw0S1YwSDhnRkVPZG1CMklRVjJOVHNUbFN0L3FIOGlBcERjcGty?=
 =?utf-8?B?V0V5K2FSNVVXbjUzNG4vVldKVGs1REUzUWhQOE9IcmJpUXFxaDBHcXhHWGR4?=
 =?utf-8?B?c0NCc04xV09qb3JMbHRxbk56OG9WSXp2SmI1UjFDdXc1SmNPTXYrWVYwRkZw?=
 =?utf-8?B?S2dNRllzKzhQYzg2QUF5NUlhaGtFSk8vZWxQV1FFbDMxVFlPQUx1VG9LRFJF?=
 =?utf-8?B?eWRzdHNZNWtGbjhIb042WnVRbFlDdzk4QStyMnlJUWh3OHQwYlRZdkdHQVdN?=
 =?utf-8?B?bDREbEpNRWhIOXR0NFZTTk90d2J0SG4vU085djNTWGt5OUxHb2pva21rcWpw?=
 =?utf-8?B?aWdKczBsSmVnVXJFaWZIYkhyTzVnL0FjZkl2WEJJQk9ScndwRUpkM0FOTFJk?=
 =?utf-8?B?T0xVRWxWV2gyc3UrRm45LzMvT0NnWDI5WXEydnFWZ1hQTWdxU2EyaFdMNzY4?=
 =?utf-8?B?QWFRaHRMQWJKbFprTDBRNlV6Vm1hcFJ2MjlVL1J0Y2xUUkswR1cyRnYvZnpQ?=
 =?utf-8?B?Z1JnUWdrMjlQK0UyWXNENFN4Wk5DMStMMnBCYjJVS1dyVFZvWk5uc0Y4akpw?=
 =?utf-8?B?U2dCMkp5bnBEVTNBOW1Wa05yVy9WVW5qd2RDS1RjbjErRlQ3cnJVMlVFR244?=
 =?utf-8?B?NjVWeURYN2l6aFg1ZTFOVEVyOFRmaGZoQUFXajF4WGExV3FqcFR0blVwcTdN?=
 =?utf-8?B?MnR4dFpGNUVIYXNmNTdHL3JSWHZIV0lJVnVMSDIyV2kwbXlsek9ia21ObnRR?=
 =?utf-8?B?d1R0Wktkd0RGL0YxWjV6M3FYbkZFRE5sTjdzZzY3N1RZZ3paRkpxck9JVm41?=
 =?utf-8?B?VFFYbFc0L2hmbGVSWmxkWHVRMUZINmMzS2pPdmtxTG5MSlhxQmgvNExRaDAx?=
 =?utf-8?B?U2ErYlp2dFI3RTFzWTluT1dIYVl0THhzazh2SHg4NDFMU1VaaWk5bVZqTjd3?=
 =?utf-8?B?RW1sTUR2dDk0RTJLZ2Ftd1FrOFgrWEkxbEVSMFFIS0lYS2xKN3pQTjFnSWl5?=
 =?utf-8?B?ZXZ0SUZzdkVjWkxVQmNBOVFMYlhQYkRvYU9ZL1pyY2pJcjRIMEFDcG1zVjU0?=
 =?utf-8?B?Y2JzZ1BHeU12MWxCZE1HYzRWL1lQVHVTVTQrUlBrZGF4eE9BU0hZeU9YNldE?=
 =?utf-8?B?SWJzZG8xbmNhd0tLa1k5d01rWnJld1lGWmpxQk1nWG5PSllpTElnK2F4dGdT?=
 =?utf-8?Q?X0vnFMAAEgIaU=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7b164f-a281-412b-e894-08dafa82064b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 01:02:38.4364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83EEm72EjoZoTzHQczgBk4QzxKIxxWBThAvBzoepcgLq7leJNYBzTaKpUn9sFtUuw5k78GpXdeQO/PjNww4Mbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
X-Proofpoint-GUID: WEsVyVKgf5_uJzIi7wRbowDJB4nChsGH
X-Proofpoint-ORIG-GUID: WEsVyVKgf5_uJzIi7wRbowDJB4nChsGH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_16,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301200005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFRodSwgSmFuIDE5LCAyMDIzLCBLcmlzaG5hIEt1cmFwYXRpIFBTU05WIHdyb3Rl
Og0KPiANCj4gDQo+IE9uIDEvMTkvMjAyMyA2OjA2IEFNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
ID4gSGksDQo+ID4gDQo+ID4gT24gU3VuLCBKYW4gMTUsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkg
d3JvdGU6DQo+ID4gPiBDdXJyZW50bHkgdGhlIERXQzMgZHJpdmVyIHN1cHBvcnRzIG9ubHkgc2lu
Z2xlIHBvcnQgY29udHJvbGxlcg0KPiA+ID4gd2hpY2ggcmVxdWlyZXMgYXQgbW9zdCBvbmUgSFMg
YW5kIG9uZSBTUyBQSFkuDQo+ID4gDQo+ID4gQWRkIG5vdGUgaGVyZSB0aGF0IG11bHRpLXBvcnQg
aXMgZm9yIGhvc3QgbW9kZSBmb3IgY2xhcml0eS4NCj4gPiANCj4gPiA+IA0KPiA+ID4gQnV0IHRo
ZSBEV0MzIFVTQiBjb250cm9sbGVyIGNhbiBiZSBjb25uZWN0ZWQgdG8gbXVsdGlwbGUgcG9ydHMg
YW5kDQo+ID4gPiBlYWNoIHBvcnQgY2FuIGhhdmUgdGhlaXIgb3duIFBIWXMuIEVhY2ggcG9ydCBv
ZiB0aGUgbXVsdGlwb3J0DQo+ID4gPiBjb250cm9sbGVyIGNhbiBlaXRoZXIgYmUgSFMrU1MgY2Fw
YWJsZSBvciBIUyBvbmx5IGNhcGFibGUNCj4gPiA+IFByb3BlciBxdWFudGlmaWNhdGlvbiBvZiB0
aGVtIGlzIHJlcXVpcmVkIHRvIG1vZGlmeSBHVVNCMlBIWUNGRw0KPiA+ID4gYW5kIEdVU0IzUElQ
RUNUTCByZWdpc3RlcnMgYXBwcm9wcmlhdGVseS4NCj4gPiA+IA0KPiA+ID4gQWRkIHN1cHBvcnQg
Zm9yIGRldGVjdGluZywgb2J0YWluaW5nIGFuZCBjb25maWd1cmluZyBwaHkncyBzdXBwb3J0ZWQN
Cj4gPiA+IGJ5IGEgbXVsdGlwb3J0IGNvbnRyb2xsZXIgYW5kIGxpbWl0IHRoZSBtYXggbnVtYmVy
IG9mIHBvcnRzDQo+ID4gPiBzdXBwb3J0ZWQgdG8gNC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogSGFyc2ggQWdhcndhbCA8cXVpY19oYXJzaHFAcXVpY2luYy5jb20+DQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBLcmlzaG5hIEt1cmFwYXRpIDxxdWljX2tyaXNrdXJhQHF1aWNpbmMuY29tPg0K
PiA+ID4gLS0tDQo+ID4gPiAgIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMzA0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gPiA+ICAgZHJpdmVycy91c2IvZHdj
My9jb3JlLmggfCAgMTUgKy0NCj4gPiA+ICAgZHJpdmVycy91c2IvZHdjMy9kcmQuYyAgfCAgMTQg
Ky0NCj4gPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyNDQgaW5zZXJ0aW9ucygrKSwgODkgZGVsZXRp
b25zKC0pDQo+ID4gPiANCg0KPHNuaXA+DQoNCj4gPiA+IEBAIC0xNTc1LDYgKzE2OTAsMjEgQEAg
c3RhdGljIHZvaWQgZHdjM19nZXRfcHJvcGVydGllcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ID4g
ICAJZHdjLT5kaXNfc3BsaXRfcXVpcmsgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGRldiwN
Cj4gPiA+ICAgCQkJCSJzbnBzLGRpcy1zcGxpdC1xdWlyayIpOw0KPiA+ID4gKw0KPiA+ID4gKwkv
Kg0KPiA+ID4gKwkgKiBJZiBubyBtdWxpdHBvcnQgcHJvcGVydGllcyBhcmUgZGVmaW5lZCwgZGVm
YXVsdA0KPiA+IA0KPiA+IG11bHRpKg0KPiA+IA0KPiA+ID4gKwkgKiB0aGUgcG9ydCBjb3VudCB0
byAnMScuDQo+ID4gPiArCSAqLw0KPiA+IA0KPiA+IENhbiB3ZSBpbml0aWFsaXplIG51bV9wb3J0
cyBhbmQgbnVtX3NzX3BvcnRzIHRvIDEgaW5zdGVhZCBvZiBzZXR0aW5nIGl0DQo+ID4gb24gZXJy
b3IgKHNpbWlsYXIgdG8gaG93IHdlIGhhbmRsZSBvdGhlciBwcm9wZXJ0aWVzKS4NCj4gPiANCj4g
SGkgVGhpbmgsDQo+IA0KPiAgIFRoYW5rcyBmb3IgdGhlIHJldmlldy4gT24gdGhlIGJpbmRpbmdz
LCBSb2IgYW5kIEtyenlzenRvZiBoYXZlIHN1Z2dlc3RlZA0KPiB0byBnZXQgdGhlIG51bS1wb3J0
cyBhbmQgbnVtLXNzLXBvcnRzIGJ5IGNvdW50aW5nIHRoZSBQaHktbmFtZXMgaW4gRFQuDQoNClRo
aXMgbWF5IGJlIGEgYml0IHByb2JsZW1hdGljIGZvciBub24tRFQgZGV2aWNlLiBDdXJyZW50bHkg
cGNpIGRldmljZXMNCnBhc3MgZmFrZSBEVCBwcm9wZXJ0aWVzIHRvIHNlbmQgdGhlc2Uga2luZHMg
b2YgaW5mby4gQnV0IHRoYXQncyBmaW5lLA0Kd2UgY2FuIGVuaGFuY2UgZHdjMyBmb3Igbm9uLURU
IGRldmljZXMgbGF0ZXIuDQoNCj4gDQo+IFNpbmNlIHRoZXJlIG1heSBiZSBtYW55IGNhc2VzIHdo
ZXJlIHRoZSB1c2VyIG1pZ2h0IHNraXAgZ2l2aW5nIGFueSBQaHkncyBvcg0KPiBldmVuIHNraXAg
ZGlmZmVyZW50IHBvcnRzIGluIHRoZSBEVCBpZiBoZSBkb2Vzbid0IHdhbnQgdG8gdXNlIHRoZW0s
IGNhbiB3ZQ0KPiBkZXNpZ24vcmVmYWN0b3IgdGhlIGJlbG93IGxvZ2ljIGFzIGZvbGxvd3Mgd2hp
bGUgbWFuZGF0aW5nIHRoZSBmYWN0IHRoYXQNCj4gdXNlciBtdXN0IGdpdmUgdGhlIFNTIFBoeSdz
IGlmIGFueSBzdGFydGluZyBmcm9tIFBvcnQtMC46DQo+IA0KPiBudW0tc3MtcG9ydHMgPSBtYXhf
cG9ydF9pbmRleCAodXNiMy1wb3J0WCkgKyAxDQo+IG51bS1wb3J0cyA9IG1heCAobWF4X3BvcnRf
aW5kZXgodXNiMi1wb3J0WCksIG51bS1zcy1wb3J0cykgKyAxDQo+IA0KPiBFeDogSWYgdGhlcmUg
YXJlIDMgcG9ydHMgYW5kIG9ubHkgMSBpcyBTUyBjYXBhYmxlIGFuZCB1c2VyIGRlY2lkZXMgdG8g
c2tpcA0KPiBwb3J0LTIgSFMgUGh5Lg0KPiANCj4gY2FzZS0xOiBwaHktbmFtZXMgPSAidXNiMi1w
b3J0MCIsICJ1c2IzLXBvcnQwIiwgInVzYjItcG9ydC0xIg0KPiBjYXNlLTI6IHBoeS1uYW1lcyA9
ICJ1c2IyLXBvcnQwIiwgInVzYjItcG9ydC0xIiwgInVzYjMtcG9ydDEiDQo+IA0KPiBJbiBib3Ro
IGNhc2VzLCBvbmx5IG9uZSBTUyBpcyBwcmVzZW50LCBqdXN0IHRoZSBvcmRlciBpcyBjaGFuZ2Vk
LiAoTm90IHN1cmUNCj4gaWYgbGFzdCBmZXcgcG9ydHMgY2FuIGJlIG1hZGUgU1MgQ2FwYWJsZSBp
bnN0ZWFkIG9mIHRoZSBmaXJzdCBwb3J0cyBvbiBhbnkNCj4gSFcpID8NCj4gDQo+IEJ1dCBhY2Nv
cmRpbmcgdG8gdGhlIGFib3ZlIGZvcm11bGE6DQo+IA0KPiBJbiBjYXNlLTEgOiAobnVtLXBvcnRz
ID0gMiwgbnVtLXNzLXBvcnRzID0gMSkgLSBUaGlzIGlzIGNvcnJlY3QNCj4gSW4gY2FzZS0yOiAo
bnVtLXBvcnRzID0gMiwgbnVtLXNzLXBvcnRzID0gMikgLSBUaGlzIGlzIHdyb25nDQo+IA0KDQpD
YW4ndCB3ZSBqdXN0IHdhbGsgdGhyb3VnaCBhbGwgdGhlIHBoeSBuYW1lcyB0byBmaWd1cmUgdGhh
dCBvdXQ/IExldCdzDQpub3QgcmVxdWlyZSB0aGUgdXNlciB0byBzcGVjaWZ5IFBvcnQtMCBpcyBT
UyBjYXBhYmxlIGlmIHRoZXkgY2FuIHNraXANCml0Lg0KDQo+IEkgYmVsaWV2ZSB0aGlzIGNvdmVy
cyBhbGwgY2FzZXMgYW5kIEkgY2FuIHJlYWQgdGhpcyBpbiBnZXRfcHJvcGVydGllcw0KPiBmdW5j
dGlvbi4gTGV0IG1lIGtub3cgeW91ciBvcGluaW9uIGlmIHRoaXMgZGVzaWduIGlzIGdvb2QgdG8g
cHJvY2VlZA0KPiBmdXJ0aGVyLg0KPiANCg0KVGhhbmtzLA0KVGhpbmgNCg==
