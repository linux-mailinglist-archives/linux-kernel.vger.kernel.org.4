Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C967C728C79
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 02:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbjFIAc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 20:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFIAcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:32:54 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BF72697;
        Thu,  8 Jun 2023 17:32:53 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358J5D29018439;
        Thu, 8 Jun 2023 17:32:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=SXhMGvVuuvUG+W2JQMKY+zNBSBATtFG9rem8x3PmBmg=;
 b=mvND0LvgC4TrS0Bor4mnAFLdnDEGfR6UmLlXkJ6LMMnTR1/xUkM7Wr2aht8tfSP9l4zY
 yZG7lcLU5V57hMXsua7Q0chM1t3I7C5BhZauilKJsWuNnyNk5sE32Nvj+dxkcnrDaLLp
 gPYzJge6A1WVOK3ZZ3D+Djf0OwUlv0WMKZ17JRnFBdnvFYJUSA53ONOuSeb+4z16FIwK
 yCQfCXVunJmkxvco/6DKCBwUDvTzTW9wHgY7GmENSjUsDtsyU4cEDZOE1ZY1NHB0grFK
 hvP+GpXjvMzFNmDT8GBpRqMeqfogvqb4wMdWdQbgIMbfRKYp8njeCYaZEqkFufjKLuDc sg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3r2a8enxd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 17:32:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1686270756; bh=SXhMGvVuuvUG+W2JQMKY+zNBSBATtFG9rem8x3PmBmg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WeL3J6RbX21Wg1LRLt/mXAq55qundju7EqOwvislVGMaXYaU9a9Yuxhz0ROth9Kjf
         uOPvX5hJjB+sovWM6cNXSX12cVLjOzmHYWpGKhhoiQY08AWDM4kZ38kx4fAxewfi1m
         MyqXmcP0OskQqXgMUgj8IDHunKxV0I11kfvmErdWCJiF1IjAE4JPrDiK5FRNW/eRUn
         Umq1cZoJ/qvgE2mVUb1GGLjlLZwNboAEqCzOs8lz/OYSbsjHxWJwo4e5WWHU6KGmC1
         eZkbKtiI/7D/7LnKbZ5GJ7h4NLAAnAV/fPIMkgUh/b462qockzXB44+eReaYd8w1Jm
         bUPTRTRpZ2HQQ==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 890DC40351;
        Fri,  9 Jun 2023 00:32:35 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B11A6A007F;
        Fri,  9 Jun 2023 00:32:34 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=wRxPQ2j3;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8757240130;
        Fri,  9 Jun 2023 00:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqNuwclwNH17JWZDA2FLYH13lB2HF2aYv2QfqApAuUREJiTBKDhBNGTyufgpLDlA8xfoTZQ7+oCYQUxcUhZX72PaJPNJE+8UFxXX9ClKpMGVPzynmWx+yxtbhDrjBMG6FKdRqRrPjpKLzvilES/FXhlYaNXOshdK6voxlyL1EmdUiq3+JV4paykHCtPy1KWFPHC5YKdaaSjePAWCCxZq9zaRouF9B1hnsbuKK0It5A05k8EgeZPmX1b0Q9hsvQGFauVdkN4yL8H5QQZhsc6ziO/5C+vTzBOkcRV5HB+etIZWqKbBBgPNtWo4bOeQcGvGK9HTFzVG9UZXvNZi3FHJNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXhMGvVuuvUG+W2JQMKY+zNBSBATtFG9rem8x3PmBmg=;
 b=PqBb0O9h9/7pcWx5zVXRERH2biUNIw4K5J7aT71nA3Nl7c+UnGXrfu2I+DsZO1L1RncF/hgo2FHc4inuPJDCB4E3bgX+ZXmaMNS1lGn7/e9lKKfDtw5s7pJabA3epBSomvrp4CVKbANeoNWsvAfcyAaL76QmN7BYo9Ij0SS6IxsX7xCWLMmGJya4Af4fXXfqxRmgBcTEWDC58rKZ839Rih7DcFHZsQBbkaqLo9nnuZ1MRkgCejgxD178WqDOn0kVqbYvCb9y7F+q1Z0BJE0SP2GUKPyafCCT3tj+qldAgH0SQksHVCNW5fconSVY7s0ACb8WIOuKK1963kmeWQ14mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXhMGvVuuvUG+W2JQMKY+zNBSBATtFG9rem8x3PmBmg=;
 b=wRxPQ2j3F97JHF91EHiJebekJCbMC6CcQZATLbTBOrJLxwiC1jOws8pPtPJufdQO5dcAAi5n/HjmmXBCWLJPRrI1PWOQg2kUL45gJfbLIRKJzDggiVmZANfVckbx/zuBfj40OxZ9ERgame3WbSsl6rgYTwJ6r5TO9RqOd6NPoXQ=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Fri, 9 Jun
 2023 00:32:30 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b%3]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 00:32:30 +0000
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
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: Re: [PATCH 1/2] USB: dwc3: qcom: fix NULL-deref on suspend
Thread-Topic: [PATCH 1/2] USB: dwc3: qcom: fix NULL-deref on suspend
Thread-Index: AQHZmTGZ4xk80SLhrkSTZ19vv2V9va+BoUyA
Date:   Fri, 9 Jun 2023 00:32:30 +0000
Message-ID: <20230609003217.2544eyd2sjwg6rnb@synopsys.com>
References: <20230607100540.31045-1-johan+linaro@kernel.org>
 <20230607100540.31045-2-johan+linaro@kernel.org>
In-Reply-To: <20230607100540.31045-2-johan+linaro@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MW4PR12MB6976:EE_
x-ms-office365-filtering-correlation-id: 3c10aea9-b8d5-42e6-11b2-08db6881023a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mID+bVrw5lPUK+aO/xpca8d5VyplAMdFlTP7R5Bb24AqDVUFwduptMyHxgX2uRNmu9tDyU/25fROyfXEgak1BRZyBj3DdBHR07yxfynRW8rf7u17cgNARm445mrknl2l0fKESgsDV8oclOuM4L+F+58hFzs0C8GqY82t5367mz5dfcbD7gLkct4AmS4t+KhUCZpT32Jp45a4zRHhlsPLXwl4BRSquG7nsWacwGEKOBDEsQVBP8MszdLxkRGZvAzxtaCCipFvtL1oAw2aiZDYlGlcMrcQ7mqdXBgj+p/Lz3w84YhHoV2pQz8ywy8N9MG/oi6cUlLuHV1CW10s8Vx6SOl77av1yZtnm9xgtMR3AXXDpsyKAXnWUJ5RNpmf5jZX5AitHOegZm937zLEpNtKE8JvvwhlFAEF0iz12LW1aLFyRHDt+xhTZBmRJLKusDyugm4vH/y+GZMkdEPSR2QT7ntiVIUCmfc66EXqtgi009PGvAp6DqEMCwhuqRZxOCfSYKlVg9yqnoygrTUT/aioL8ge8g/cV4lVIFezFkTKaUlS5ykN5U23RHP1vaxLb2cI0U2GeIHLDPPg4QIbWv6PJTswFcf+spWJMn14mfkeW04=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199021)(54906003)(122000001)(478600001)(8936002)(4326008)(38100700002)(76116006)(66946007)(66556008)(66446008)(316002)(66476007)(64756008)(41300700001)(2616005)(8676002)(186003)(966005)(71200400001)(6486002)(83380400001)(6512007)(6506007)(1076003)(26005)(7416002)(15650500001)(5660300002)(86362001)(38070700005)(2906002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjk0RjNSZkVFeUc5UVpqZVU4NmZBUVU0di91aUNxam5adEN0UWgweWx3TTNR?=
 =?utf-8?B?U1JxazEvazZyM2hLQkdXV0FWMFVnbGhsZlU5M0FGSjl6SnJMWmVyazhXLyt3?=
 =?utf-8?B?dTdZQmlTcFJxMjJzdy9NSkZKTXpNQmhUQUxZTSt6ZVgrQkpTNkxXeTRCWCtG?=
 =?utf-8?B?VVdmQUk5aThxa2NEUGNWb2NqVVBWSUtOQmZ2bHd1dU1hTVFEdElUeU5KckxS?=
 =?utf-8?B?VkNvTFZlcmRSaGZXdTBtSDYrYWRmMG9Db1BjWVFjZ0RMM2NEdmh6WllCT1VN?=
 =?utf-8?B?RG1iWmpjTnl4MnEyS29QdkhaWEcwQVRtSzZ4V28yYWtacHU1WGRnNDB2bEZR?=
 =?utf-8?B?eEJ3YVhrVlpvMmhZd1poUXcxTDZGYzJXQUxFQUxRemx0VENTVUJhMytjaDRI?=
 =?utf-8?B?enpCMU10QXZCSktoSlFmNklXK2pJeFU3amI5Qm5zckV1cWloYkYzSTQyVmF4?=
 =?utf-8?B?bFJmcll6cXFvMDc0S2hXVFhBMWVSempRZ09LWWI0L0pmdVJTcnZ2enNGZUhF?=
 =?utf-8?B?QXN2WkJ2UTFORHBYWWtCdHkvcys3NFEyVmx1UEh5Q2IrMGlmdWNIWlRIQ0U0?=
 =?utf-8?B?V1QyWXZXbDVkZGtNZGNYOGN3aGw0UFNQdi84RExFamVZNHRtU3g1ZHQzM29P?=
 =?utf-8?B?bUh3ZUtnaTZBR3AzTmZDZzdUVVowSkQrTWZrY3p5Qk9HSGZGT0tjS1BQTHZK?=
 =?utf-8?B?Ly9hOVRiZnUyNCtZU2JwMlhVMmMvNTFnYVdCS2VtTGczcUpIT3p1cXdzSUda?=
 =?utf-8?B?QlNTVHFaMnk5S09mUHVGdGJPaXhJT09aSkNhR0dHbkxwTTU4WHBkZnVnbmhS?=
 =?utf-8?B?YURKemZ1dGxmN0Qwd0I5aFQ5N3hqWjd5NlpsSHRPZFZwdDlkMEFnTVBqMlUy?=
 =?utf-8?B?UjMzeTJIYkdMbWxKc1MwTTNMdmZ5VDBpNnVtK0RMeDlFZFRNU1R3QVVhMzJu?=
 =?utf-8?B?WDB5c25JUGFXdGo2TC9jT0NIby84cHE4VVYraFI3dW1Gc1BLVkhmYmdKcXhD?=
 =?utf-8?B?cThNdHhmcUJnSklzYUo3YU9Qeno0NlllakZnVm0yQmh6K3JDcVRoQkhlV0RB?=
 =?utf-8?B?OWJ3a2RFYS9IcDl4QU9qdkFNWTRSZCtaLzVlQWJxRGFydzJKQTlnZUExNFFJ?=
 =?utf-8?B?Y3ZEUXlhV1RkZ1Y1dFF1SCs1eU5VZXZTUTBiYms0bTB2NVFycnNjS1ltS1Ft?=
 =?utf-8?B?eTFEM1ZxQTNFK0YwT1dDeDhTa21UU0hCY0lkRHNsby9PaDk4TStlakZxNHZy?=
 =?utf-8?B?T2RyUE05bWlmOEhUUGxDMkVFUTlBbENPcUowclEzdllQOGhlQW1CZ0hUOFJh?=
 =?utf-8?B?WERwT2F2d2ZseEFRTi9IZjFJd01mTEVHOUFpczlMSkpORmZBWmlLVFlJQTZZ?=
 =?utf-8?B?Nmpoa1JhVDVzV2JiYisyR1F2NDJ1NHN5blFuNlpWbm5mTWVZeHRYYW5EekQz?=
 =?utf-8?B?SEt3MGw0RWRMdXpMNFBWa1Z6cU1ldTg3RU9UY1UrbDJMQWpGL2VpUW1UNVJj?=
 =?utf-8?B?SzZUSUZZZHJPRit2dm94UGxSVVJiSlA2MDJOdlZnUy9QeHFTV00wSlFvTnRz?=
 =?utf-8?B?UklDNG1nYmZ1UjZtRmVkbG9GcjdiT1dzV1M3VVBlZFlWckdjS2Q2d3BUL25Q?=
 =?utf-8?B?cVNtaWpJVDZ3QXEyK1VrSEpYcDRBNXdSWnpyM0h2WmxPaTVwR012WndVbEpv?=
 =?utf-8?B?dElrNlMwNTRPSjdvSEpNRjZjcEh0MHQ1dXJ4NnNrc2paOHo5T3dHNTlXMnpP?=
 =?utf-8?B?NTRMN0pGOGJFOFpSVlh1ZDhDc2lnbDVadE1wTXBTT09xSzRLeE8zVllhRnhE?=
 =?utf-8?B?c2JJNXlCOFhuUXlWeXJNUk5Qd0ZoemhpMXhXOTVnaUE4cUNSSGt2SXppSEty?=
 =?utf-8?B?QUwzKzBFK3krN3F2bm5Gd2FqSHVmejk3UVRxWlBqSUZ6cERKRVdPY0p6TE15?=
 =?utf-8?B?T1ZaRnkyNnhDSndoNDJHc0h5b3dhdm96T2hHc3hLQkhqTDV3VlBjZjJ6VVN1?=
 =?utf-8?B?NW9raXB6enZPMzVlUUIyTzNRaTluL21MbEpmeEtzZjdLcjltZG9JT3RQVDlI?=
 =?utf-8?B?ZlUwNU9XZWxXb2hlYW5qdC9aOGczc0pVKytlQlZUS2pjQUhTSEw5RkRUMExt?=
 =?utf-8?Q?sqOXd25RVvcitF9XasMFfCF9G?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <428D809186EF2547B1B2643EAFDF77C4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bjh6WWFpT2tDZUZ6UEY0SlQxV01TenhWSGJBVTh4RE9jclZESUlUQmJiWHlV?=
 =?utf-8?B?dWQvZDJqZ1lTcVpjU3g4R0gyeTNEM1BtMmZiVi9iL1plRmljTitIdFVLNzh1?=
 =?utf-8?B?ZFRLSkhXblJvQWhIRnR2VzlXZGV3Zi8rTEJQd085bXRDQTc5Umk4OHVHODMy?=
 =?utf-8?B?b2lkVGhZVW1acitRRjFPbUtmVzFkUTdnVk9EOHdoSWVVcmRsdm8vbEhlYStX?=
 =?utf-8?B?Y09sSWtrL01lWENVYXFEUmtHTHdsUmZNVVhXK0ZCa2FKY280dW9PSDVRSndn?=
 =?utf-8?B?SjFEOXErZFN4ZEZsSXEzcXlLWlBqamphajAwWFl1OFYvS1dJaXJMZGFqM0J0?=
 =?utf-8?B?WU8rcjRncVdkV0JUbDZYMG5JS05JYzFqNVpqS09Oby9NWHlyTiswRHhFeDRH?=
 =?utf-8?B?Nnh1bVM3c2J4UWZmSDFTVDlTTkVXVDFodHE2T1ljbUpzR3pNYnh0bFltNGJs?=
 =?utf-8?B?TEY1Z24vMmJ4d1JYamFwTS9EVUMvZ1NnN25peW5HUkRqaUs3NUp5MDJCVU5Q?=
 =?utf-8?B?aEpYMm16aWtta05jV21RNk10cUpNNVhEaGNFaTVnaitkb1pXZU1qMGJUN0Ft?=
 =?utf-8?B?UTlRbUVpUmVkQUVCR0c1a0JOd1k0OUFYa2EvdmVCNCs3ODU1clZ4NnczRHIy?=
 =?utf-8?B?bXZXMy9mUGtQRzZFWXVaK2N6V1RzQzFmZStBQTg4QmpSQTh5L0NPeXBGSjl4?=
 =?utf-8?B?Vm5iL0ZNbmxTUURSUGU4NlRJT1YrbEF0YUxORDFmbnJ6Yk5kOExoSFdaOVdw?=
 =?utf-8?B?aEdmd2kwV1pTWFREQ0VKb250bmhpZmNtZjl4WWhJcTFDLzN5UTJ2SFY3NzJP?=
 =?utf-8?B?bTlzYU1TVWUyWWNwd0lVV1dyd0w1M04xWVJ2MDR3N0w3UjE2WVhFUlhXU1dV?=
 =?utf-8?B?V1dXTTBuUUUrcmRYSHlnTFVnaUJjanZncm0vekFqUGZnTjkwRUNtZ2owYTNr?=
 =?utf-8?B?RGpidmV5cXdobzdpczV4N1c2SmVWSFR5Mko4a2h6YTdUOE1tNTNqd1BGUnJ2?=
 =?utf-8?B?SHRKYnJsOGhDVzlQZ0lIUUk4eCthZzdOVTVCUGNOYmJYbU1QMUJBMXE1MFVG?=
 =?utf-8?B?UEd6VlgyMTRKK2tHbk1IbWRYQ1BxQzl3N0ZVU2RGVEdMMWM5SHRPd25IaHdS?=
 =?utf-8?B?U2VXV00zV3pQNGFrOXo3L0xkTkk2U1A5Z3gyTWFma3NJSXJlUWZTU0tocEg4?=
 =?utf-8?B?dXdzQ0JGeVZEK1RBdjBsWkFKeUIycUFXbG9ZU1VFN05adVhjR1FtSFpDWEdB?=
 =?utf-8?Q?Xn/gcq4HWpY+yZV?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c10aea9-b8d5-42e6-11b2-08db6881023a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 00:32:30.0358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4YH5CY/HJB264gwmj76LxcNtp5Y4IeufQQ80vZsmVfbf2WICoKOLaG18UOM6I7eSQtKsE4m/mmCsh7jPkLPhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
X-Proofpoint-GUID: o8Re8tEGffzaTpLTsV315mUmEbkJWe93
X-Proofpoint-ORIG-GUID: o8Re8tEGffzaTpLTsV315mUmEbkJWe93
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_18,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306090002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdW4gMDcsIDIwMjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4gVGhlIFF1YWxjb21t
IGR3YzMgZ2x1ZSBkcml2ZXIgaXMgY3VycmVudGx5IGFjY2Vzc2luZyB0aGUgZHJpdmVyIGRhdGEg
b2YNCj4gdGhlIGNoaWxkIGNvcmUgZGV2aWNlIGR1cmluZyBzdXNwZW5kIGFuZCBvbiB3YWtldXAg
aW50ZXJydXB0cy4gVGhpcyBpcw0KPiBjbGVhcmx5IGEgYmFkIGlkZWEgYXMgdGhlIGNoaWxkIG1h
eSBub3QgaGF2ZSBwcm9iZWQgeWV0IG9yIGNvdWxkIGhhdmUNCj4gYmVlbiB1bmJvdW5kIGZyb20g
aXRzIGRyaXZlci4NCj4gDQo+IFRoZSBmaXJzdCBzdWNoIGxheWVyaW5nIHZpb2xhdGlvbiB3YXMg
cGFydCBvZiB0aGUgaW5pdGlhbCB2ZXJzaW9uIG9mIHRoZQ0KPiBkcml2ZXIsIGJ1dCB0aGlzIHdh
cyBsYXRlciBtYWRlIHdvcnNlIHdoZW4gdGhlIGhhY2sgdGhhdCBhY2Nlc3NlcyB0aGUNCj4gZHJp
dmVyIGRhdGEgb2YgdGhlIGdyYW5kIGNoaWxkIHhoY2kgZGV2aWNlIHRvIGNvbmZpZ3VyZSB0aGUg
d2FrZXVwDQo+IGludGVycnVwdHMgd2FzIGFkZGVkLg0KPiANCj4gRml4aW5nIHRoaXMgcHJvcGVy
bHkgaXMgbm90IHRoYXQgZWFzaWx5IGRvbmUsIHNvIGFkZCBhIHNhbml0eSBjaGVjayB0bw0KPiBt
YWtlIHN1cmUgdGhhdCB0aGUgY2hpbGQgZHJpdmVyIGRhdGEgaXMgbm9uLU5VTEwgYmVmb3JlIGRl
cmVmZXJlbmNpbmcgaXQNCj4gZm9yIG5vdy4NCj4gDQo+IE5vdGUgdGhhdCB0aGlzIHJlbGllcyBv
biBzdWJ0bGV0aWVzIGxpa2UgdGhlIGZhY3QgdGhhdCBkcml2ZXIgY29yZSBpcw0KPiBtYWtpbmcg
c3VyZSB0aGF0IHRoZSBwYXJlbnQgaXMgbm90IHN1c3BlbmRlZCB3aGlsZSB0aGUgY2hpbGQgaXMg
cHJvYmluZy4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2
YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBMaW5rOiBodHRwczovL3VybGRlZmVuc2Uu
Y29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwMzI1MTY1MjE3LjMxMDY5
LTQtbWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmcvX187ISFBNEYyUjlHX3BnIWRrNnBn
MlhKaktTS0JtemxvYlF3UE9YRGVuNEdIUi13VzUzc0JlNzFnMFg2Z2JDN0FmT2VQaHJiNzZvVExO
NnlIV1R2S0J5X3k1cHdTRTFfSFRBU01oT25kNXp6JCANCj4gRml4ZXM6IGQ5MTUyMTYxYjRiZiAo
InVzYjogZHdjMzogQWRkIFF1YWxjb21tIERXQzMgZ2x1ZSBsYXllciBkcml2ZXIiKQ0KPiBGaXhl
czogNjg5NWVhNTVjMzg1ICgidXNiOiBkd2MzOiBxY29tOiBDb25maWd1cmUgd2FrZXVwIGludGVy
cnVwdHMgZHVyaW5nIHN1c3BlbmQiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwkjIDMu
MTg6IGE4NzJhYjMwM2Q1ZDogInVzYjogZHdjMzogcWNvbTogZml4IHVzZS1hZnRlci1mcmVlIG9u
IHJ1bnRpbWUtUE0gd2FrZXVwIg0KPiBDYzogU2FuZGVlcCBNYWhlc3dhcmFtIDxxdWljX2Nfc2Fu
bUBxdWljaW5jLmNvbT4NCj4gQ2M6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVp
Y2luYy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFuIEhvdm9sZCA8am9oYW4rbGluYXJvQGtl
cm5lbC5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYyB8IDExICsr
KysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMgYi9k
cml2ZXJzL3VzYi9kd2MzL2R3YzMtcWNvbS5jDQo+IGluZGV4IDk1OWZjOTI1Y2E3Yy4uNzliMjJh
YmY5NzI3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcWNvbS5jDQo+ICsr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMNCj4gQEAgLTMwOCw3ICszMDgsMTYgQEAg
c3RhdGljIHZvaWQgZHdjM19xY29tX2ludGVyY29ubmVjdF9leGl0KHN0cnVjdCBkd2MzX3Fjb20g
KnFjb20pDQo+ICAvKiBPbmx5IHVzYWJsZSBpbiBjb250ZXh0cyB3aGVyZSB0aGUgcm9sZSBjYW4g
bm90IGNoYW5nZS4gKi8NCj4gIHN0YXRpYyBib29sIGR3YzNfcWNvbV9pc19ob3N0KHN0cnVjdCBk
d2MzX3Fjb20gKnFjb20pDQo+ICB7DQo+IC0Jc3RydWN0IGR3YzMgKmR3YyA9IHBsYXRmb3JtX2dl
dF9kcnZkYXRhKHFjb20tPmR3YzMpOw0KPiArCXN0cnVjdCBkd2MzICpkd2M7DQo+ICsNCj4gKwkv
Kg0KPiArCSAqIEZJWE1FOiBGaXggdGhpcyBsYXllcmluZyB2aW9sYXRpb24uDQo+ICsJICovDQo+
ICsJZHdjID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocWNvbS0+ZHdjMyk7DQo+ICsNCj4gKwkvKiBD
b3JlIGRyaXZlciBtYXkgbm90IGhhdmUgcHJvYmVkIHlldC4gKi8NCj4gKwlpZiAoIWR3YykNCj4g
KwkJcmV0dXJuIGZhbHNlOw0KPiAgDQo+ICAJcmV0dXJuIGR3Yy0+eGhjaTsNCj4gIH0NCj4gLS0g
DQo+IDIuMzkuMw0KPiANCg0KVGhhbmtzIGZvciB0aGUgY2F0Y2guDQoNCkFja2VkLWJ5OiBUaGlu
aCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNCkJSLA0KVGhpbmg=
