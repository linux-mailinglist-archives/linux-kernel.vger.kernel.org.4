Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F2F6B5613
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjCJX4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjCJX4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:56:14 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A9212CB83;
        Fri, 10 Mar 2023 15:56:12 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ALn8eT024195;
        Fri, 10 Mar 2023 15:55:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=cJhXh3xmy0rCl65BSwUPxmvue5nWR1DeldOVf+PVMhY=;
 b=F8m3GW4PcAucv+pBQxYR2nBMCmxwgsQwxNx7J7+8M3DYa7UFnfuxrrX1YALpdgszh88o
 LHY3ujVYgcFbqLjle5KfY0wcobr41no5NtvKXH6iXS14T/kEmBtUEcIk6uB7hlDiiXe3
 Hb9KIb7aUwCNGL0LPYY/SEiQaLnppBH3LVslKWPjH479Vtc/VyMIJ4x+IcY8EemgO7Uz
 pxRe4Ox/aMKBem4zv+MD0nO5h9/oA6inksP7yGUMehsVMHcqHNRSzSHPcEKjqJ0BXkS+
 ga9Jntnlf1GpDmsRxQ+APF2oeZghX41gqNrXA0Xm3yQ4H5qD8Hexc6RyjCp4Wf3TmlI2 2g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3p6fen4vmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 15:55:49 -0800
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0EB4540083;
        Fri, 10 Mar 2023 23:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1678492549; bh=cJhXh3xmy0rCl65BSwUPxmvue5nWR1DeldOVf+PVMhY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kEkmvbmDeDkhdaRuoGplI2Aqy24mMuuD/kmn/1JkjydL7uO4HbTlWkinVgAl4uq8A
         FMIdgSR0QWfE+ceS8Sm1fUEsJpnTpdabBVzaJFC81SAt2C52ZOXr1cTD4Iv2YvRb3W
         tr+IxhUogjXARaXZsCxG0DryShqqM3ekCiELr52Sezr8ZC5sYRC6305bthMD7kb/a+
         ykK/dEpR+VMLswCbVR7cYjZHz99n9YZaMB3DNhwhzcGjFtG1JDyQSuG635RpYoORhK
         J8bi70RSfM8AjXkDZMM1Y5gytQjEN5ddKttqbboOyRsq/95fSU3VEzgV3IKskYmjzz
         9oHzouDMInX/w==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D3159A008E;
        Fri, 10 Mar 2023 23:55:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E2387800B3;
        Fri, 10 Mar 2023 23:55:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="NnOF5seH";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZtdb8iom8MYGNGjOMILnjoa4ci2TUGW/iJna0SqAKPRIuI/4tdu6RXKSU3SY7a7DsDxl9Iiq6oQXnvh7Veb03W6DuNyWrDg8cgbDsqVjrdhyVDRW4b6yBOzW0Kl0Lys1szmcCol1l2A2lts/kd6eGcjMiaC+GAAmbP1ST243wPsVrHOjtinqc2o6387RD08gWLSiFtvbSsjisP3+uStx88Yd1TE1whRlW8R0IAyG7BzOb0HCQukLqNvafy4802zjPJ+kINGvbieSFJjlvk6zLyQSQAqDw7X/SYKZWIbZ1r9k+ToiaIn85xEQTXlt8pHYpbaJqIATo1wot2yM2UfMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJhXh3xmy0rCl65BSwUPxmvue5nWR1DeldOVf+PVMhY=;
 b=miu4pad11Yd6ub0joP2Ax7JWqMfsIG74y50jN9Il/QKl1wbs+1FlAX8h1xQ7ZxD6Wy2eMkjkNU0b++e5DYXXmcL7hOMLyDrJ4k2ZHEPYozqVLIVHFm0ItdLz6xXz8oUQy42RH278AN2+CtNx63ZrBx/wBWqq3t6szyuw93VfbaZjb2pvdcWXFChC/kY33lUrpzm2rSR5Ul9xFol0TL7Iz/5SHqCnJj6nb9/o2tiw0Hyq5DXf66yd7FebeYl8LZa7s9eegmv3H7FrqxE9MgiIhhz35XjU2UBMsiK5AV4IGuvXE2Wbn4n+iWLc4xZ6kyK4qU5uUd3Y6iclB32Ab5zTOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJhXh3xmy0rCl65BSwUPxmvue5nWR1DeldOVf+PVMhY=;
 b=NnOF5seHwKxmNW7wWeEX9lFzH2nTdejCdhaeToSr+5oVI6SPJ8Ucy2oN4yQP9SmTlmyiMCmYbPzUeBF2Zrj2jNlAxK8MMDX6I4j0mjSN94mGxWLIHwQuPNz1p7mal5SFppNrRyTPpZ5fpG1kX3SuLmr1v8Y+7nCnUUHxzaQPMxM=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH3PR12MB8281.namprd12.prod.outlook.com (2603:10b6:610:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 10 Mar
 2023 23:55:41 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 23:55:41 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
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
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH 2/8] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Topic: [PATCH 2/8] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Index: AQHZU25OkivR3WhNOEuJyDnjX7usOq70sMKA
Date:   Fri, 10 Mar 2023 23:55:41 +0000
Message-ID: <20230310235537.afl76rs3pcifbn46@synopsys.com>
References: <20230310163420.7582-1-quic_kriskura@quicinc.com>
 <20230310163420.7582-3-quic_kriskura@quicinc.com>
In-Reply-To: <20230310163420.7582-3-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CH3PR12MB8281:EE_
x-ms-office365-filtering-correlation-id: 1dc7f285-dc05-4fd6-92d3-08db21c2f48f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZMOGf5goQO4ekS/hQf/hRnNxIlnnWHB22PNu6pWeApHwwCncqJeYlWWGP8nESuvxgI7y78Ua4no5ldXWXu8yYi/ATgRXtrOcdLO4HTNPEoydbWbF+TtUy/Rqem+hIb6KH8yuwOiO0BqL2pYHQOc+qY0qmDY2E00ZXA8l6kDjrQDlNzDSq933P/PXZ+m1qZIn4droL2Bv8C8dGwO7daYsOWVTj+fD73V1a6FTnV2a/a4eu3p+1Mp1BVG7KZpWYHFK4IeBYAH+rzYrqMXd0mvnhOHc87i/hDGs02COwe2a/8u5BGXCFND5B7wYjvudugjuAcveYpGuvE0UVK4WyFWo7LGsT3Ay5Y3bJw8d7k+pE1xcI70hpgZfsZOrANyM7dFbw/+u7ZLJ1OlXax8e55aufPAsQiL2qtc2+qt8FzEKh20+gGt273XF2NLnsuK/leis++436TYl/ykBm9eS9sBNZOAhKMwfdqQ1MFO7uhOFpcx+t6OHAbleh+El9iU16QkQS9UkuDWrRKB8XrVjihNU15qY80vCQsDUs8FLRIj2QrAZpF54lRuyOx+L9oVxEXbgN3UYFaBodhUJhNFE8socB4OXItVxP8t3fSLeZPWpcuo4qltxL3D6SewBAeFesOTw5AOWaLded+Zj10P56NkMZMvuTKuKyvEWMZ7zMRZxnWaP9j9PGC9LqbNkamuZuWjQRDndDLHzVGRDwGcWgtmpdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199018)(83380400001)(36756003)(478600001)(54906003)(122000001)(38070700005)(316002)(38100700002)(71200400001)(186003)(2616005)(6486002)(6506007)(6512007)(26005)(1076003)(7416002)(41300700001)(2906002)(5660300002)(66476007)(6916009)(76116006)(8676002)(64756008)(66556008)(66446008)(8936002)(86362001)(66946007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wis0a0dDTENlQ2JFZnZqNGNxd0h4dWJRZitFY05HdVovN0FTWmlSSy9xWVVs?=
 =?utf-8?B?ZkV0ZGRsYzc1ZXJ2NmhvaVdEQTFiSStlUW5uamtMNTRkaDdzbXV0RDR1QXha?=
 =?utf-8?B?czZkOFUvK3dJUHEwTWJBeXNRMG1XL21NVjZ6dXV4NDg1UmJ3ZW1WakV2VGZx?=
 =?utf-8?B?LzM1Qkt3N0tXaWVUa3Z4VzQ1bHF0UXJGamtUOEFoWDlOaFpUdGx1UjMrVTBw?=
 =?utf-8?B?MEZIZFIrbEZIMGRYS2hsbXdQbTBLVDArSGpnekVJYjRvWEpxMXpBRFdUWW05?=
 =?utf-8?B?TE1xTHA5VmtYaFdHU0JUZ1RMYWE4N3U5QmZOa3phOWsrbGtuaU81RFBsTzgy?=
 =?utf-8?B?ZzZvbS95N2szc2lzYVArYlh5b1FIaytUekdJVFV3RS9zMlFySy9vSTQwUENB?=
 =?utf-8?B?UDdlYWRydXl2bjdvMTNuR3gwaUo2RjR5K29JTUREWVV2U0RMbGtvSjFQbXh6?=
 =?utf-8?B?Wm42UjZFWUNNKzE2cVJDdm0xWjlKM3JuM1gvL29Iald0Q3lVT1o5MWF0ZmNT?=
 =?utf-8?B?VWdRakVsZVJnY3lTK1NtSjdHT24xTW1HaFFPa0lJV1RTby9wd0pBUDdwbFJT?=
 =?utf-8?B?SDRqaWVvZzRibVhrN3pzYkxhdjNXbHp6cG93OHU0Z281cUhQS3dROFI3aEts?=
 =?utf-8?B?K3pCcWpmM2VUTmc2TVN2d2hTN2dZLzJ5RnJ3Nm1OR1VTbEIyTC9rWi9LWTl5?=
 =?utf-8?B?Y05LTGl3a1FVeWdoZjdiQkZxQUUxOGwrZEtNdVVtQ2M0THl4RzlGckdDdGFG?=
 =?utf-8?B?WWt4WEE0MlBtU2ZSWldLQjUxWUV3dS9MRDZZb0ZJQXlwOHJDTU8wblNxTlZB?=
 =?utf-8?B?cmYwL0g0WmphQVUyekUwclNaZW9iZk1yYk5wbklWY3Z2dXdNYzhJU0pjM1Bq?=
 =?utf-8?B?NnBoM3RyL2MxNXM5SnJ5UnlRMzNncGZ3Z01HNlRwUmw1cHdwR2d6U3RCMFN0?=
 =?utf-8?B?YjY5ajU4M0ZJN1F0anlJRXphTVI3WDBlbGwzY1EyWWlZZG5TTW8wQlpCK0cr?=
 =?utf-8?B?UVpRbkpXN3ExR2pIYmVlcXB5K0lteG5sK0hBTUx4YWZXSk5Ob1JJd1UwQlRY?=
 =?utf-8?B?K2gxSHV5YkwvNkZpU0JmeHJxeDVCTVRtbDlqRS9FMWx6OGtmZnh2Qk45QlNV?=
 =?utf-8?B?YkxUZXd0TWRHSTUxekJKbWIzWEpWSEdmWjhIV3VhdGVja3FuczR0TDVJQWdV?=
 =?utf-8?B?S1h4aDZsNUk0YW5rWHVadTdZVXF3N05naml3dk95dXlSbEl2aFNITy9paDFn?=
 =?utf-8?B?aWFWNXg1bVhocWhOZk5LR2tiWTlWTkowVlBRSVhnYXoxUmRZVG1MNXBBZ0w5?=
 =?utf-8?B?WFNCaW8rYmg1Z1JPd3JpN0ZtZFI5T3N1Z1Z6d0t3YTZIZ09LWG9yZW1OTEdS?=
 =?utf-8?B?MlRUTmxBdm0yNnFRcW1nbGhoSno3bVhJSitvUlJUZnBKaDJ0T1lWbHRLeTZT?=
 =?utf-8?B?bEJ3eDBaNnZ3OC9DRnkxbHd6eTh5cFQ5U3dwa2RncTJuOCtocE9yTmRvMHcy?=
 =?utf-8?B?YUY1UVE0R0dRRlEzZTN5Sm9NcjlsUnhKZStLcUZBeUVWUHdJMHpkZENTa01S?=
 =?utf-8?B?MmxLaFA0ajNpdFQ4Uy9EUWI1VE9iVE9OY05jNVFVMVhNOUVWNCtXZ2YrYVRa?=
 =?utf-8?B?NUtBUnBtOExiMHE3VFJoZDVkWk5ZZ3ZYc3U1aTYwTVRzdzVLQTdET1gxaStL?=
 =?utf-8?B?Y1R4Mi83dHhqNWdGRFp5Z2V1SVFIVzgzY3VXQ1kxdHVFOUJFWlJCUkp3Lzgw?=
 =?utf-8?B?bWo4STEvVTVPWEFjMzZtYklvMVpWcDlOUjhnalNRUHJ3TnM4T3pPNHJTN20x?=
 =?utf-8?B?NkxWQjQxUk9nK0wrNVpBNWJweTRSYTRKTnp5RzVnTWpLTVBPRXhYYlNGa2Z1?=
 =?utf-8?B?Y3llV3IzekN1c3JpZ2ZQYlhneTNFUGVHTkJ1Q0twMGFpQzVMZW5mZlpERk8v?=
 =?utf-8?B?WnBlSjB4Z3hhSVhhTDQ5S3NBazB1ZER0TWFJbW8rTWQzSnAvZkFLQkk0QndL?=
 =?utf-8?B?NzAzWTUwOUVXc1RyRm5YbklLbkk5WE5Mb0ZOY0lUTXhRbkdkV3oxMjZTVlpU?=
 =?utf-8?B?L3RXdFpwRGdUbTZsd3ZlZGVrMDJucHpVR012VmxHaXhhUWRJb0NTMENwSVVU?=
 =?utf-8?B?SFJnN3BHcEg4VEhuN3hsZitNMW1PM3ByNlRjOFVKdHNhS0puV2hxV1ZLZm52?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB16B894A4084B41B41FDBD2E74FAADE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Z1pRbzlzTjdMSWJTWVNQa1FIQ2syMmQ2SStzRVhIajJHWVNMRUtsWUc0UURz?=
 =?utf-8?B?YmZtYmpXL2hQakJGSFBvZmJ1czUyUU1ObTBMcGFYS2gwUFhYUEFQOEM5elA3?=
 =?utf-8?B?YU9hV1RzSnE3L0hCMzA3YXM4UDNNTElqbGJkRm5xZ2c3SjJ4a3NHaHhBQ2Nt?=
 =?utf-8?B?UXZCb3ZBc09lUy9sVGVlM2JHQi9jNnJyREVwN0lielhlaUZMWHZuTWV3Um9x?=
 =?utf-8?B?MHBLMjNLTFZzYUtsbjB4b2JqUE10cTBkYkVNeE13NFJIM2dDUXhKeHJWN21X?=
 =?utf-8?B?eE5Da3U5Q2pCN2NZYlY2eVMxUWRTSUhiWWlkbnNJd08wNWZrVG1sbWlTSFdR?=
 =?utf-8?B?azFocEthUlBzcVBHZWI1S3VISVJ3MUdlMWdXVllGbVBEaWZHTVpZcThlakJm?=
 =?utf-8?B?dU9vUC9JRGVVbEJ6QUFZcmJXSDBnZjhNNzN3MHY5RWtMWkFjR2JHMExXd0Nq?=
 =?utf-8?B?dnpsSjRXREtGTXFNa09jamNrR2VGa3NTMHFka2NFZElwZnlXRU5TK1ZOMHdH?=
 =?utf-8?B?NHZ0UWRmNjF2RTI0NWtBU3FjbTZ4YVZjbXRDSzIwVzRWaE9iU1RnTzQ3L2tP?=
 =?utf-8?B?cHhHTDVpVDd0bzhnOTJnSnFVSlRUTnpESnA0WUk5c0hKaVJXNEs2SjRvVFA0?=
 =?utf-8?B?dHYzNHJmS1k5cStaLzdzUk02Y2dMNzc5REl6eWdyUy8vUUpway9EWGxkTEhw?=
 =?utf-8?B?N2hmUTBzcHdJcElQTkZCdzRCTWZNaW1kTGJXVWlLUjRqTk4rdmFQSllwUitD?=
 =?utf-8?B?Slo5dmEveEc3S1RGS2ZROUtqUDhBU1ZCTDlQeCtjbEhvLzlrazFBZ3RENldn?=
 =?utf-8?B?dlFJekFDamhqamtwNmNLd3d4OTgzemp6SzRjZ0Q2VEprRkgzeWtrSE5VVGI3?=
 =?utf-8?B?SDQxRmoxemV3WnBkbmluOTdrMldBeDVVNU8xZVlKcWNWaEVpNkFoaU5jeVZj?=
 =?utf-8?B?TnBYZ1A0eEYwczFHWW9OcEV4WVVkWkNNUW1qUjNVYk84ODlzK0lTTk9TQWln?=
 =?utf-8?B?ZUNzNGk1RFhrZ2o2R2tJdWl1Sk9hbG15bmJ4VDM4UEtFeVduL202d2toMTV0?=
 =?utf-8?B?Z2FPOURIbTVhbit4U2F1VncrOHhLeFpGNXBKNk5jOXRNeUtyQ0pwa1dBVWdQ?=
 =?utf-8?B?bGlxRmxnSXRWbmRwekliMkFTbE9heHBnNDlEUmZ6YnpqWmxjSEV2aVQ3WHhN?=
 =?utf-8?B?T1hQMFczZXp5LytDZlZYYkE2U2NjMllmS1U3MTRzcmc5LzJZY2VIODFLTXFK?=
 =?utf-8?B?a0FESXdCMmJTdzNIOWJLWVFXVlpGMjVsRC80ZVVoS1hCaTEzTVAxYnVocWsz?=
 =?utf-8?B?My9iVjBJZXh0WEdVUlBLbGo3bUZPNjZlQ1Nnc2w3MUpZWUNFS1FwRHExZzl3?=
 =?utf-8?B?TVkvLzA1YW16SVE9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc7f285-dc05-4fd6-92d3-08db21c2f48f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 23:55:41.3166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wOfZsNsVrTbI3hP/z5SoDlwkprt8wS6x7p1J9WtaKmqbsAp7WC1T89yGKHLtOZ1OeEEBNNNHNBcwYm29oxre2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8281
X-Proofpoint-ORIG-GUID: LlFmDItzm19U8GofFWu8ILgs4pa3sbEV
X-Proofpoint-GUID: LlFmDItzm19U8GofFWu8ILgs4pa3sbEV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 spamscore=0
 clxscore=1011 malwarescore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXIgMTAsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IEN1cnJlbnRs
eSBob3N0LW9ubHkgY2FwYWJsZSBEV0MzIGNvbnRyb2xsZXJzIHN1cHBvcnQgTXVsdGlwb3J0LiBU
ZW1wb3JhcmlseQ0KPiBtYXAgWEhDSSBhZGRyZXNzIHNwYWNlIGZvciBob3N0LW9ubHkgY29udHJv
bGxlcnMgYW5kIHBhcnNlIFhIQ0kgRXh0ZW5kZWQNCj4gQ2FwYWJpbGl0aWVzIHJlZ2lzdGVycyB0
byByZWFkIG51bWJlciBvZiBwaHlzaWNhbCB1c2IgcG9ydHMgY29ubmVjdGVkIHRvIHRoZQ0KPiBt
dWx0aXBvcnQgY29udHJvbGxlciAocHJlc3VtaW5nIGVhY2ggcG9ydCBpcyBhdCBsZWFzdCBIUyBj
YXBhYmxlKSBhbmQgZXh0cmFjdA0KPiBpbmZvIG9uIGhvdyBtYW55IG9mIHRoZXNlIHBvcnRzIGFy
ZSBTdXBlciBTcGVlZCBjYXBhYmxlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS3Jpc2huYSBLdXJh
cGF0aSA8cXVpY19rcmlza3VyYUBxdWljaW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYyB8IDc1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCB8ICA5ICsrKysrDQo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDg0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDQ3NmI2MzYxODUxMS4u
MDc2YzBmOGE0NDQxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiAr
KysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMzcsNiArMzcsNyBAQA0KPiAgI2lu
Y2x1ZGUgImNvcmUuaCINCj4gICNpbmNsdWRlICJnYWRnZXQuaCINCj4gICNpbmNsdWRlICJpby5o
Ig0KPiArI2luY2x1ZGUgIi4uL2hvc3QveGhjaS5oIg0KDQpJIHRoaW5rIGJldHRlciB0byBkdXBs
aWNhdGUgc29tZSBvZiB0aGUgbG9naWMgaW4gZHdjMyBkcml2ZXIgYW5kIGF2b2lkDQphbnkgZGly
ZWN0IGRlcGVuZGVuY3kgd2l0aCB0aGUgeGhjaSBkcml2ZXIuDQoNCj4gIA0KPiAgI2luY2x1ZGUg
ImRlYnVnLmgiDQo+ICANCj4gQEAgLTE3NTAsNiArMTc1MSw2NSBAQCBzdGF0aWMgc3RydWN0IGV4
dGNvbl9kZXYgKmR3YzNfZ2V0X2V4dGNvbihzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCXJldHVybiBl
ZGV2Ow0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgaW50IGR3YzNfcmVhZF9wb3J0X2luZm8oc3RydWN0
IGR3YzMgKmR3Yywgc3RydWN0IHJlc291cmNlICpyZXMpDQo+ICt7DQo+ICsJdm9pZCBfX2lvbWVt
CQkqcmVnczsNCj4gKwlzdHJ1Y3QgcmVzb3VyY2UgICAgICAgICBkd2NfcmVzOw0KPiArCXUzMgkJ
CW9mZnNldDsNCj4gKwl1MzIJCQl0ZW1wOw0KPiArCXU4CQkJbWFqb3JfcmV2aXNpb247DQo+ICsJ
aW50CQkJcmV0ID0gMDsNCj4gKw0KPiArCS8qDQo+ICsJICogUmVtYXAgeEhDSSBhZGRyZXNzIHNw
YWNlIHRvIGFjY2VzcyBYSENJIGV4dCBjYXAgcmVncywNCj4gKwkgKiBzaW5jZSBpdCBpcyBuZWVk
ZWQgdG8gZ2V0IHBvcnQgaW5mby4NCj4gKwkgKi8NCj4gKwlkd2NfcmVzID0gKnJlczsNCj4gKwlk
d2NfcmVzLnN0YXJ0ICs9IDA7DQo+ICsJZHdjX3Jlcy5lbmQgPSBkd2MtPnhoY2lfcmVzb3VyY2Vz
WzBdLnN0YXJ0ICsNCj4gKwkJCQlEV0MzX1hIQ0lfUkVHU19FTkQ7DQoNCklzbid0IGR3Yy0+eGhj
aV9yZXNvdXJjZXNbMF0gYWxyZWFkeSBzZXR1cCBhdCB0aGlzIHBvaW50PyBDYW4gd2UgdXNlDQpk
d2MtPnhoY2lfcmVzb3VyY2VzWzBdIGRpcmVjdGx5IHdpdGhvdXQgY29weSB0aGUgc2V0dGluZyBp
biBkd2NfcmVzPw0KDQo+ICsNCj4gKwlyZWdzID0gaW9yZW1hcChkd2NfcmVzLnN0YXJ0LCByZXNv
dXJjZV9zaXplKCZkd2NfcmVzKSk7DQo+ICsJaWYgKElTX0VSUihyZWdzKSkNCj4gKwkJcmV0dXJu
IFBUUl9FUlIocmVncyk7DQo+ICsNCj4gKwlvZmZzZXQgPSB4aGNpX2ZpbmRfbmV4dF9leHRfY2Fw
KHJlZ3MsIDAsDQo+ICsJCQkJCVhIQ0lfRVhUX0NBUFNfUFJPVE9DT0wpOw0KPiArCXdoaWxlIChv
ZmZzZXQpIHsNCj4gKwkJdGVtcCA9IHJlYWRsKHJlZ3MgKyBvZmZzZXQpOw0KPiArCQltYWpvcl9y
ZXZpc2lvbiA9IFhIQ0lfRVhUX1BPUlRfTUFKT1IodGVtcCk7DQo+ICsNCj4gKwkJdGVtcCA9IHJl
YWRsKHJlZ3MgKyBvZmZzZXQgKyAweDA4KTsNCj4gKwkJaWYgKG1ham9yX3JldmlzaW9uID09IDB4
MDMpIHsNCj4gKwkJCWR3Yy0+bnVtX3NzX3BvcnRzICs9IFhIQ0lfRVhUX1BPUlRfQ09VTlQodGVt
cCk7DQo+ICsJCX0gZWxzZSBpZiAobWFqb3JfcmV2aXNpb24gPD0gMHgwMikgew0KPiArCQkJZHdj
LT5udW1fcG9ydHMgKz0gWEhDSV9FWFRfUE9SVF9DT1VOVCh0ZW1wKTsNCj4gKwkJfSBlbHNlIHsN
Cj4gKwkJCWRldl9lcnIoZHdjLT5kZXYsICJwb3J0IHJldmlzaW9uIHNlZW1zIHdyb25nXG4iKTsN
Cj4gKwkJCXJldCA9IC1FSU5WQUw7DQo+ICsJCQlnb3RvIHVubWFwX3JlZzsNCj4gKwkJfQ0KPiAr
DQo+ICsJCW9mZnNldCA9IHhoY2lfZmluZF9uZXh0X2V4dF9jYXAocmVncywgb2Zmc2V0LA0KPiAr
CQkJCQkJWEhDSV9FWFRfQ0FQU19QUk9UT0NPTCk7DQo+ICsJfQ0KPiArDQo+ICsJdGVtcCA9IHJl
YWRsKHJlZ3MgKyBEV0MzX1hIQ0lfSENTUEFSQU1TMSk7DQo+ICsJaWYgKEhDU19NQVhfUE9SVFMo
dGVtcCkgIT0gKGR3Yy0+bnVtX3NzX3BvcnRzICsgZHdjLT5udW1fcG9ydHMpKSB7DQo+ICsJCWRl
dl9lcnIoZHdjLT5kZXYsICJpbmNvbnNpc3RlbmN5IGluIHBvcnQgaW5mb1xuIik7DQo+ICsJCXJl
dCA9IC1FSU5WQUw7DQo+ICsJCWdvdG8gdW5tYXBfcmVnOw0KPiArCX0NCj4gKw0KPiArCWRldl9p
bmZvKGR3Yy0+ZGV2LA0KPiArCQkibnVtLXBvcnRzOiAlZCBzcy1jYXBhYmxlOiAlZFxuIiwgZHdj
LT5udW1fcG9ydHMsIGR3Yy0+bnVtX3NzX3BvcnRzKTsNCg0KVGhlIGVuZCB1c2VyIGRvZXNuJ3Qg
bmVlZCB0byBrbm93IHRoaXMgaW5mby4gVGhpcyBzaG91bGQgYmUgYSBkZWJ1Zw0KbWVzc2FnZS4g
UGVyaGFwcyBpdCBjYW4gYmUgYSB0cmFjZXBvaW50IGlmIG5lZWRlZD8NCg0KPiArDQo+ICt1bm1h
cF9yZWc6DQo+ICsJaW91bm1hcChyZWdzKTsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+
ICBzdGF0aWMgaW50IGR3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
IHsNCj4gIAlzdHJ1Y3QgZGV2aWNlCQkqZGV2ID0gJnBkZXYtPmRldjsNCj4gQEAgLTE3NTcsNiAr
MTgxNyw3IEBAIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiAgCXN0cnVjdCBkd2MzCQkqZHdjOw0KPiAgDQo+ICAJaW50CQkJcmV0Ow0KPiArCXVu
c2lnbmVkIGludAkJaHdfbW9kZTsNCj4gIA0KPiAgCXZvaWQgX19pb21lbQkJKnJlZ3M7DQo+ICAN
Cj4gQEAgLTE4ODAsNiArMTk0MSwyMCBAQCBzdGF0aWMgaW50IGR3YzNfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJCWdvdG8gZGlzYWJsZV9jbGtzOw0KPiAgCX0NCj4g
IA0KPiArCS8qDQo+ICsJICogQ3VycmVudGx5IERXQzMgY29udHJvbGxlcnMgdGhhdCBhcmUgaG9z
dC1vbmx5IGNhcGFibGUNCj4gKwkgKiBzdXBwb3J0IE11bHRpcG9ydC4NCj4gKwkgKi8NCj4gKwlo
d19tb2RlID0gRFdDM19HSFdQQVJBTVMwX01PREUoZHdjLT5od3BhcmFtcy5od3BhcmFtczApOw0K
PiArCWlmIChod19tb2RlID09IERXQzNfR0hXUEFSQU1TMF9NT0RFX0hPU1QpIHsNCj4gKwkJcmV0
ID0gZHdjM19yZWFkX3BvcnRfaW5mbyhkd2MsIHJlcyk7DQo+ICsJCWlmIChyZXQpDQo+ICsJCQln
b3RvIGRpc2FibGVfY2xrczsNCj4gKwl9IGVsc2Ugew0KPiArCQlkd2MtPm51bV9wb3J0cyA9IDE7
DQo+ICsJCWR3Yy0+bnVtX3NzX3BvcnRzID0gMTsNCj4gKwl9DQo+ICsNCj4gIAlzcGluX2xvY2tf
aW5pdCgmZHdjLT5sb2NrKTsNCj4gIAltdXRleF9pbml0KCZkd2MtPm11dGV4KTsNCj4gIA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuaA0KPiBpbmRleCA1ODJlYmQ5Y2Y5YzIuLjc0Mzg2ZDZhMDI3NyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgN
Cj4gQEAgLTM1LDYgKzM1LDkgQEANCj4gIA0KPiAgI2RlZmluZSBEV0MzX01TR19NQVgJNTAwDQo+
ICANCj4gKy8qIFhIQ0kgUmVnIGNvbnN0YW50cyAqLw0KPiArI2RlZmluZSBEV0MzX1hIQ0lfSENT
UEFSQU1TMQkweDA0DQo+ICsNCj4gIC8qIEdsb2JhbCBjb25zdGFudHMgKi8NCj4gICNkZWZpbmUg
RFdDM19QVUxMX1VQX1RJTUVPVVQJNTAwCS8qIG1zICovDQo+ICAjZGVmaW5lIERXQzNfQk9VTkNF
X1NJWkUJMTAyNAkvKiBzaXplIG9mIGEgc3VwZXJzcGVlZCBidWxrICovDQo+IEBAIC0xMDIzLDYg
KzEwMjYsMTAgQEAgc3RydWN0IGR3YzNfc2NyYXRjaHBhZF9hcnJheSB7DQo+ICAgKiBAdXNiX3Bz
eTogcG9pbnRlciB0byBwb3dlciBzdXBwbHkgaW50ZXJmYWNlLg0KPiAgICogQHVzYjJfcGh5OiBw
b2ludGVyIHRvIFVTQjIgUEhZDQo+ICAgKiBAdXNiM19waHk6IHBvaW50ZXIgdG8gVVNCMyBQSFkN
Cj4gKyAqIEBudW1fcG9ydHM6IEluZGljYXRlcyB0aGUgbnVtYmVyIG9mIHBoeXNpY2FsIFVTQiBw
b3J0cyBwcmVzZW50IG9uIEhXDQo+ICsgKgkJcHJlc3VtaW5nIGVhY2ggcG9ydCBpcyBhdCBsZWFz
dCBIUyBjYXBhYmxlDQoNClRoaXMgaXNuJ3QgdGhlIG51bWJlciBvZiBwaHlzaWNhbCBVU0IgcG9y
dHMgcmlnaHQ/IFRoYXQncyB0aGUgbnVtYmVyIG9mDQp1c2IyIHBvcnRzIHRoZSBjb250cm9sbGVy
IGlzIGNvbmZpZ3VyZWQgd2l0aCByaWdodD8uIFBlcmhhcHMgd2UgY2FuIHVzZQ0KbnVtX3VzYjJf
cG9ydHMgYW5kIG51bV91c2IzX3BvcnRzPw0KDQo+ICsgKiBAbnVtX3NzX3BvcnRzOiBJbmRpY2F0
ZXMgdGhlIG51bWJlciBvZiBVU0IgcG9ydHMgcHJlc2VudCBvbiBIVyB0aGF0IGFyZQ0KPiArICoJ
CVNTIENhcGFibGUNCj4gICAqIEB1c2IyX2dlbmVyaWNfcGh5OiBwb2ludGVyIHRvIFVTQjIgUEhZ
DQo+ICAgKiBAdXNiM19nZW5lcmljX3BoeTogcG9pbnRlciB0byBVU0IzIFBIWQ0KPiAgICogQHBo
eXNfcmVhZHk6IGZsYWcgdG8gaW5kaWNhdGUgdGhhdCBQSFlzIGFyZSByZWFkeQ0KPiBAQCAtMTE1
OCw2ICsxMTY1LDggQEAgc3RydWN0IGR3YzMgew0KPiAgCXN0cnVjdCB1c2JfcGh5CQkqdXNiMl9w
aHk7DQo+ICAJc3RydWN0IHVzYl9waHkJCSp1c2IzX3BoeTsNCj4gIA0KPiArCXUzMgkJCW51bV9w
b3J0czsNCj4gKwl1MzIJCQludW1fc3NfcG9ydHM7DQo+ICAJc3RydWN0IHBoeQkJKnVzYjJfZ2Vu
ZXJpY19waHk7DQo+ICAJc3RydWN0IHBoeQkJKnVzYjNfZ2VuZXJpY19waHk7DQo+ICANCj4gLS0g
DQo+IDIuMzkuMA0KPiANCg0KVGhhbmtzLA0KVGhpbmg=
