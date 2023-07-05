Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A32D74911C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 00:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjGEWsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 18:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGEWsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 18:48:15 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F331700;
        Wed,  5 Jul 2023 15:48:14 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365M4t4g028377;
        Wed, 5 Jul 2023 15:48:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=J9uutZzI4VklxFMwaZKgtaSodepPkGy+FteoLUZegE0=;
 b=U0lK9h5rPIxHVp++4UrdnpgBx9p3ywCP6NfcYkOdzK3XfkKUf1qJOptvqleZUiWgb6Kz
 HpHYT8ZJFLAcC46oYEC/GAgxlV8vfDLjsc33F0H69aetFnsKbG3lXkpjQDJ8MVXRAxcp
 +DpLnVdhjA2rZQTIfF2xZGYjywZ7Y7vEpJAxbHftxYaXeynvyQsXdKTFA39PQ7G+bThT
 lMrSF5wnOAOzitxwna0yEndXCrpmwtCdDgGFNZX3yHSe29zBqSj7frjBjeoVxoQbGQ9s
 vv2Rwllpt+ihfqpVN98hlzK1jDyzGICU7k7XRgNGcg5ij6P7Sh/ZoD4uZbiOVYvCw+45 Ow== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3rjkd4g24y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 15:48:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1688597285; bh=J9uutZzI4VklxFMwaZKgtaSodepPkGy+FteoLUZegE0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IvfGyhrwvPCW+EXU4mwVgdWa77dFJcw8stW8GT4SDr/MW6OxJ04w78VK0/UvCHF0+
         KA57nXe2Qpy/0y0fKvPNPy6lEO4WNMK9JhyQCPJfqyCVkXYssf46ummRxN4fyO/otA
         XLIwXeBfiNaoX1mawls5GjdAqhoZoo3AOaAi1PZx9BZ4roSBw2VEXe0/rvWRDGc17a
         CRqRLcUxEUYaj1KEvkMnwwT1T6z8QXM0h0P2m7yep/v9rpSgQVH/vzqj4/R4u/aZjr
         W73qO7bRqMlZjDH1rC8ZcCG77UARVOsSjFMTG7YrDEOs4iP8Jk2x1eXOhTRvCz1f6H
         E8pG+9/NFPgQw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2930A401DC;
        Wed,  5 Jul 2023 22:48:04 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 58D73A0144;
        Wed,  5 Jul 2023 22:48:03 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=lX04A/qC;
        dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1EAD140354;
        Wed,  5 Jul 2023 22:48:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvqHu0ntZz+S6jbzL+QqwoiN/aTTlnDN4CxQzP0bffToMh6CFrTK+2/eeg7fUt/9B8urEzP1i2nNCyBmlvXnhH6WHb64Jt+hB4TNN5VTB3k5sXnOzQv8wjYkQatOn1SiDUky3mYaWBLV2GxeJS0mxDi5k8umYV2QNjwWDsFzv9sz3jsQwMPKJyvpxZb3rSRGR2eOB27XfrZC7iEZJCqruJFUZi5WCnTLk0KVjtN/cHYECvGP/oIPkEguRGe05aDLHVaVpOKwHGtcdHlGnnpY/STM8KnAkiph4DVsB7mR8xZVYPpr8LNiNdvgDRfxiPQNHUd36QRIT2Hu0aU2NXkyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9uutZzI4VklxFMwaZKgtaSodepPkGy+FteoLUZegE0=;
 b=FDzQGwmVoMFZN39V9NZV2SVqY+FlZHlJpY+ep9Jblw4dbjQbqNov4FnU6YvhWFFB++Ci7pMPUn2wq41mqYSMSCZNRf1eBcwkzPA6CepNcUmPltjUjcQFCgKOWRtd4nKhHoq/Wrw9qOX/4sm1bD0134BoMze1NnLbG3Np0613t7b5cKRJY9M25O35yJKx3m2kWQRlUcPeKZ6u2J4iTt4bhuvacYz8Ybf69KfvLaCyKymH40eePH+noG25DEptVq33Nl9E7KUNFUgKT99zIbJa4HxAwseh/jSDVFm6DynhVGPPtvGp5qcd9pBekk7ujcCVLsFWNxX6jqSJF+JPWqN2vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9uutZzI4VklxFMwaZKgtaSodepPkGy+FteoLUZegE0=;
 b=lX04A/qCGHkLt2Sbwgz5sikqSFOnYgbOQSdP07Rb7hJyP6n5PVxnY7LcJtdq6hQ3KLMB7AloTjE8KEow9+sFZZq5mBiFS2V8CjLXjlhOUGZpBzvy7K01tWUPjVDdrMI2kOQsa2fO5dkci4PZhqJADjl833gcBkaYopIXQNlS/EQ=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 22:47:58 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b%3]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 22:47:58 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jakub Vanek <linuxtardis@gmail.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mauro Ribeiro <mauro.ribeiro@hardkernel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] usb: dwc3: Disable AutoRetry controller feature for
 dwc_usb3 v2.00a
Thread-Topic: [PATCH] usb: dwc3: Disable AutoRetry controller feature for
 dwc_usb3 v2.00a
Thread-Index: AQHZq6N8Rx/zK10gr0O1P8J0n8tAsq+rzjEA
Date:   Wed, 5 Jul 2023 22:47:57 +0000
Message-ID: <20230705224754.zmffebz2geg3bclh@synopsys.com>
References: <20230630223638.2250-1-linuxtardis@gmail.com>
In-Reply-To: <20230630223638.2250-1-linuxtardis@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|LV2PR12MB5896:EE_
x-ms-office365-filtering-correlation-id: 7974e849-159a-4812-123c-08db7da9e0ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tbvBC31pSB7qWnoaNKJ/jaXrSu1yXmePi1K8aS8DjSt7MBz7xP6I3unBOnMU4jqkIbt9iJAVefGJiBQoQ9mx1b+Git1iCQ8y7q0V3NWVSQfWMwl0+ZSd42HjW5ObrLCP2Rd5lF7XzXbahw/H5mXIqyfMXZz3loNLPSAYzJ4YHZnNw+vKmyp5UeW0XScVshhWb/8dOnlSiECToOYfa54BDh8SQGBeSAK+44UU/g61Z042N0jDQNFhbtCsOhvfu1yM3E8XzdRmY9GRd5J3oDe1kdqX+OgztuUbW/Wc3n9RwxynrEjcRdwXx8EsdnVxVXI8uyH8VroOb4ibFwSsrJNZkST4oLzTQvGzlQiUKPXKhwTMy90yzUpGeZafC1sWmLkjBqFuOYC/FV/ZLVeWzrdHmfHmgJmTinuzZOigS3OQSFSJ43cEvscMTbzN9p+H07Ucj2Vm4VW43c444rSaXdgTXw6jpY9m1Qq7fX5YiebYQjWX8SB7J2SsgJGU8fcXJDPSBfPGOFUpUwJGoE9x4bpGyKG0QK1ZFinNKQAtyQVuPLkNY5WO4RWXT6jYKS5fSyeg0qjG8IHmG34FFa4ocxdAV48mQ/oYKIWtloEIK8T56LA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199021)(16799955002)(36756003)(66476007)(8936002)(38100700002)(5660300002)(8676002)(6916009)(41300700001)(38070700005)(66446008)(64756008)(66556008)(86362001)(316002)(4326008)(91956017)(76116006)(66946007)(122000001)(966005)(2906002)(6486002)(26005)(1076003)(6506007)(6512007)(186003)(478600001)(54906003)(83380400001)(71200400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2pFbVVRemoyd0NhcVl2ZnhsRyt0K2w5bkk1Q09YUHdyTm9Hd3VLekxGdzJi?=
 =?utf-8?B?TDVudk84MkZnL29ka1l3NlM2anRzNkFMb0hUQ2lTZFZ0NWxKZW96eU82eG1j?=
 =?utf-8?B?UHpsRHhlLzJFdjcrTys3K2VKL3lBZ1lkSEpNcU00eEZLNUhiT3l0RHFiWDFR?=
 =?utf-8?B?b1UzRnB1QktIcFNkWTFrYkJvT01lNjdMKy9JOFN2ZWtMT0hCRmp0alpEc3Zl?=
 =?utf-8?B?V1ZOZld5NGFDRjY4dDRkS0RwMk15aDRtZ1Q1Zm1OK2hiT0FZWlpHaU9Lenlr?=
 =?utf-8?B?ZUUrYWtxalhwa0pXTVdBcEgvVnQ1YzdsN1cvUVpGQXozVmoza1g3b1E2dXN3?=
 =?utf-8?B?TmJpM3Jmcml5LzF6KzdWeFNYVGdkamF6VmNYeGVSaXV4KzdsekJJaXN2anRu?=
 =?utf-8?B?VUR2aVUxUjFTRXJMTHBtZjcyNzRHdnhaZklyNUNPYzhIMHdHSE9KdWVhSmkr?=
 =?utf-8?B?VWUydHVqblR4aDZKbkcxK1JQb3E0SEVvS29JUGlqaHFINzZFM3JHaEdmak5Z?=
 =?utf-8?B?VVNwNVZUVnoybFhxMHlkZkpycUh3ODY3dXQ2WWo3eVdhcmwyYjVGbGRtRi93?=
 =?utf-8?B?ZDAwNDhCeTFYaDlHUnNnY3Rvb2puOXE0VTl0Tm9pNzdvdUFjMXdEVE1MOGpQ?=
 =?utf-8?B?M1ZaWEo0WlhzZU0xREE5OTdWcWtabC9qNVVUTmp4RDJIQm5vT2prWUJ1Y21B?=
 =?utf-8?B?bVByVk10L01MV1JRd2RFQ3h1NzVTTjVGUU5uMXZoWVQ4aFNlb29oYjZRWHkw?=
 =?utf-8?B?UGlEYkJuRHpObmFabEliNm9ZZ1J6WmVMNkVIVjI5djNTeERkc2l6RjVLbnRD?=
 =?utf-8?B?WGVaMEIxaWNjdHFlUnA2YWFxUWdZd2NDNWZhVS84RldyWHRES1lWanN2MlV5?=
 =?utf-8?B?aUFlempqektmaVU1NEJyYXFuRFlsY2xldHRHR25DcytMOU1UeXFma1JvRmFX?=
 =?utf-8?B?R25mYkpEUlRnclVtVG1hMWFaNTBJQUNHNHAxYm5WL0hzWWIrcFlmMFYwUExT?=
 =?utf-8?B?NnRmMlJJTTkxakw1Q2Zpd3ZNWEliUVVZb2cvdTRQMjFSY3QxT3gxclRsSDRB?=
 =?utf-8?B?UDc2M09KSXI4MUUrbmxWUFY1Q2tkNmc2cWw4RjV1d01HTklqSXJrektDUFFy?=
 =?utf-8?B?cUwybzh3Uk5lYVAxZVF6VlUzZXJmUHo4YmEzeE16SXpGVUg0TmdtTGdadTJ2?=
 =?utf-8?B?V0FYSjB3VTZ5MWpvZzZ6WDVqUjlIdEpNeVNoYWxVa1pxeERYTEV1L2tPNVEy?=
 =?utf-8?B?TDJkTEE1Ujh1eHIzNWFnaks0T1M1NE9wUkRaN3N4TUdrejFBY2RKL1dWTk42?=
 =?utf-8?B?ay9UdE0vTnlLUkd1NWZaM1FYSmtKOHZlZVJUQWtXcWZGUXM4MDhhZnFCeEo5?=
 =?utf-8?B?YWtpQUVUS3RQV1Q2N2xhajhpaHlndkxnTThMcmVacFlpY25STkNZZndQWUpT?=
 =?utf-8?B?dGVLZXlMWmFRZllCeVBOMVhIaFdLM2hOT01qQlExWWNrdTNucXk3RDNXZEli?=
 =?utf-8?B?L3VNQVdkOGg2M2NQOFNtNlpBRUl1RjRob1pnTWVyTnltWXNJNzcyMWZuK3FW?=
 =?utf-8?B?Yk4vdm1kWWd1THcveXdFRXk0bUV4dFNuVFZyajRGRUZiZFZ2bTVSVTR2ekRv?=
 =?utf-8?B?Q3V4L3c2ZzdBbkQrWTd2QTVBZEJ4WGx3emorNVBHTDhzQVNsRUpKSlQwalFU?=
 =?utf-8?B?eFh6UHhweFUvc1RqMnl4VUYzcnVGR0psbUtVTGZCdjhHdjRjanZValNLMllk?=
 =?utf-8?B?SWVaWVlmUnRqZkxWNVhmTmlIdm1YbVo3dVVvUmFOL2FMd0s0Y292alBlZjdV?=
 =?utf-8?B?OU5BREhTQ3ZZeCs3MWZxK1kzQ0twRU1UQ1lrM05DSVRWc3VNc28xTmhRejlS?=
 =?utf-8?B?dm5ocWJlZ1B6QXFtdEpEeVk2MTlRbGpaYlI3Zy9tNUplTjFwc1pYcHE2Mllt?=
 =?utf-8?B?KzAxaDc2MkQwdDUzdTBoZFN2TmJsaGFEQXE0dWdPamdtRHJURG4vVUk1bURs?=
 =?utf-8?B?M0J4OGpXSTBydndGYzJNTFlTbituYk8yeXZLTkdIUGFNWXFoRDVXSkN4bFhV?=
 =?utf-8?B?QWI2N2VqU09Hbk1tRW0xa3VkbmVSTmtnZ3lFSmEzeFRwd1ZJRkh0MXVJYVc1?=
 =?utf-8?Q?j0tXQmnsjUe2kPwkWVt3DkBcM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C95EBAB5EFF2AD4D839938D8F8E2617A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dnNKOW1HcnpNeSs1SWxRNGhYV3g0N3BrWGQxdzQ2VWs0QUhUZUtLUitkVDAv?=
 =?utf-8?B?VlRPQ2NyYkFsblZaWXVzT0Qxemp5WmpLY0lRTm5SRGl6TEJEOTBOelN5UUVl?=
 =?utf-8?B?VDFZS0xpS1V6ZjVhbExZTkZtWFMyQ3gyZFlMSW42TnlDY292aGNjelVPTmJl?=
 =?utf-8?B?RUpUMjN3aG5YMnVoamVxcG1taGd2Y0dkTXBmMmU5d3lET2F3TTQ0SDN1NDNx?=
 =?utf-8?B?d3RTTyt2V0NNeXBScis5OStqRHZSSGR3a2k5TnA1RVM5SUhscTA3OVlRd0s4?=
 =?utf-8?B?NjRiSnEvNTVVOExGQXMwQjZVQlRiRVFnYkNPTEZkclVWWW81U0J3Y3JGS1FV?=
 =?utf-8?B?a2U1RkU4NVBKclpTSzVuL3k4MkU1amttRCtFZ3Y0bDNPQk1tRnhPQjF5Vy8v?=
 =?utf-8?B?T2F0WXdCUmIyWXdyOUppclN5S0xhZCtNZjY2UXcwSkc5U0l0SHlXTGVXTWVD?=
 =?utf-8?B?MlNmOWpBOWR2dERwanpXSWVTcHdNMkVBTm9LZzVTSDRoMHRJaWttbGRzdEJ3?=
 =?utf-8?B?bzRvSElKZVQ3SnRoYmZGa2kwZm9GNS90TDk0ZjRjOWdCWW56VCtmRTJwcmk5?=
 =?utf-8?B?cjgxQ3AwNmJVM1ZCdlZ0RnNNV0JqRHpMWjVjOGdJZ0U2VzVRZmx4Mm41WTJr?=
 =?utf-8?B?b01VdWw3THAvczZtaDVGKzBTYksycVZ3UG1UOXAxYkpxMEsrM2RWeVVPYkZY?=
 =?utf-8?B?Sm44VkdrZFVRZlBPcmR4M0xudjdSMzV2SU0zd1RycDR1Q3JFSEgyNnMxV25i?=
 =?utf-8?B?Um5idno3K2hETGdzamlVdFVhTWRpR0RDWDNpNUZ2Q3Z6MXBGNU5VUFVKbmVt?=
 =?utf-8?B?NVd4OStaTmp2aWFYTTFjQU5Ld24yeVdwU3dsQy9vL29ZSENXUzFxUnNBTnFl?=
 =?utf-8?B?MFF3ZWZTV2Q2VnVOZmZyeW92YTVuM21qVXpNNi9XY1Qrc2ZxQ2R0V0xWTER5?=
 =?utf-8?B?OXpiM3hubC9OUUo1ZkFhaVgzU0xnKzQ1ZG11cGh3aUYwdThvd0szOUxVcDdk?=
 =?utf-8?B?TW5SVEZ3RUtwVjF5cXRvUis0RnoxRnFMazRneCtsWWU1RU02bGJjN0RNcU80?=
 =?utf-8?B?NzU2N0hKM1VKRGVpY1NUT2x4QzZBazNrR0RQdXRXWTNvOVVIMlpwVHA4M2lx?=
 =?utf-8?B?ZlBOd0JtR2xtNDZYUkVQb3l5dVR5TGQvQkVjaG1Ta1h3VnRMNGxFWEcrT1px?=
 =?utf-8?B?Tm9NM21YamtYV3hwWjZ0KzFjSzFNS3BGQkQxL2g3aUxuenFkQUhneDFMSUpn?=
 =?utf-8?B?TU9zT3VudGJkcXI0WFdRQUgvMnRCVGZPYzFmQnpCMzV2RFJ3Zz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7974e849-159a-4812-123c-08db7da9e0ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 22:47:57.9483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TMvchxkB4bp3ldUkjvUcVCUSTY6bjEI4oyQUG14/7MGZatKmFhJthW+TuGWzwnDvWAqMVvs0jIXyGB1dzli50Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
X-Proofpoint-GUID: bidKpcB23e4t0nZWfJktxOJPwiex4H66
X-Proofpoint-ORIG-GUID: bidKpcB23e4t0nZWfJktxOJPwiex4H66
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307050205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFNhdCwgSnVsIDAxLCAyMDIzLCBKYWt1YiBWYW5layB3cm90ZToNCj4gQXV0b1Jl
dHJ5IGhhcyBiZWVuIGZvdW5kIHRvIGNhdXNlIGlzc3VlcyBpbiB0aGlzIGNvbnRyb2xsZXIgcmV2
aXNpb24uDQo+IFRoaXMgZmVhdHVyZSBhbGxvd3MgdGhlIGNvbnRyb2xsZXIgdG8gc2VuZCBub24t
dGVybWluYXRpbmcvYnVyc3QgcmV0cnkNCj4gQUNLcyAoUmV0cnk9MSBhbmQgTnVtcCE9MCkgYXMg
b3Bwb3NlZCB0byB0ZXJtaW5hdGluZyByZXRyeSBBQ0tzDQo+IChSZXRyeT0xIGFuZCBOdW1wPTAp
IHRvIGRldmljZXMgd2hlbiBhIHRyYW5zYWN0aW9uIGVycm9yIG9jY3Vycy4NCj4gDQo+IFVuZm9y
dHVuYXRlbHksIHNvbWUgVVNCIGRldmljZXMgZG8gbm90IHJldHJ5IHRyYW5zZmVycyB3aGVuDQo+
IHRoZSBjb250cm9sbGVyIHNlbmRzIHRoZW0gYSBub24tdGVybWluYXRpbmcgcmV0cnkgQUNLLiBB
ZnRlciB0aGUgdHJhbnNmZXINCj4gdGltZXMgb3V0LCB0aGUgeEhDSSBkcml2ZXIgdHJpZXMgdG8g
cmVzdW1lIG5vcm1hbCBvcGVyYXRpb24gb2YgdGhlDQo+IGNvbnRyb2xsZXIgYnkgc2VuZGluZyBh
IFN0b3AgRW5kcG9pbnQgY29tbWFuZCB0byBpdC4gSG93ZXZlciwgdGhpcw0KPiByZXZpc2lvbiBv
ZiB0aGUgY29udHJvbGxlciBmYWlscyB0byByZXNwb25kIHRvIHRoYXQgY29tbWFuZCBpbiB0aGlz
DQo+IHN0YXRlIGFuZCB0aGUgeEhDSSBkcml2ZXIgdGhlcmVmb3JlIGdpdmVzIHVwLiBUaGlzIGlz
IHJlcG9ydGVkIHZpYSBkbWVzZzoNCj4gDQo+IFtzZGFdIHRhZyMyOSB1YXNfZWhfYWJvcnRfaGFu
ZGxlciAwIHVhcy10YWcgMSBpbmZsaWdodDogQ01EIElODQo+IFtzZGFdIHRhZyMyOSBDREI6IG9w
Y29kZT0weDI4IDI4IDAwIDAwIDY5IDQyIDgwIDAwIDAwIDQ4IDAwDQo+IHhoY2ktaGNkOiB4SENJ
IGhvc3Qgbm90IHJlc3BvbmRpbmcgdG8gc3RvcCBlbmRwb2ludCBjb21tYW5kDQo+IHhoY2ktaGNk
OiB4SENJIGhvc3QgY29udHJvbGxlciBub3QgcmVzcG9uZGluZywgYXNzdW1lIGRlYWQNCj4geGhj
aS1oY2Q6IEhDIGRpZWQ7IGNsZWFuaW5nIHVwDQo+IA0KPiBUaGlzIHByb2JsZW0gaGFzIGJlZW4g
b2JzZXJ2ZWQgb24gT2Ryb2lkIEhDMi4gVGhpcyBib2FyZCBoYXMNCj4gYW4gaW50ZWdyYXRlZCBK
TVM1NzggVVNCMy10by1TQVRBIGJyaWRnZS4gVGhlIGFib3ZlIHByb2JsZW0gY291bGQgYmUNCj4g
dHJpZ2dlcmVkIGJ5IHN0YXJ0aW5nIGEgcmVhZC1oZWF2eSB3b3JrbG9hZCBvbiBhbiBhdHRhY2hl
ZCBTU0QuDQo+IEFmdGVyIGEgd2hpbGUsIHRoZSBob3N0IGNvbnRyb2xsZXIgd291bGQgZGllIGFu
ZCB0aGUgU1NEIHdvdWxkIGRpc2FwcGVhcg0KPiBmcm9tIHRoZSBzeXN0ZW0uDQo+IA0KPiBSZXZl
cnRpbmcgYjEzOGUyM2QzZGZmICgidXNiOiBkd2MzOiBjb3JlOiBFbmFibGUgQXV0b1JldHJ5IGZl
YXR1cmUgaW4NCj4gdGhlIGNvbnRyb2xsZXIiKSBzdG9wcGVkIHRoZSBpc3N1ZSBmcm9tIG9jY3Vy
cmluZyBvbiBPZHJvaWQgSEMyLg0KPiBBcyB0aGlzIHByb2JsZW0gaGFzbid0IGJlZW4gcmVwb3J0
ZWQgb24gb3RoZXIgZGV2aWNlcywgZGlzYWJsZQ0KPiBBdXRvUmV0cnkganVzdCBmb3IgdGhlIGR3
Y191c2IzIHJldmlzaW9uIHYyLjAwYSB0aGF0IHRoZSBib2FyZCBTb0MNCj4gKEV4eW5vcyA1NDIy
KSB1c2VzLg0KPiANCj4gRml4ZXM6IGIxMzhlMjNkM2RmZiAoInVzYjogZHdjMzogY29yZTogRW5h
YmxlIEF1dG9SZXRyeSBmZWF0dXJlIGluIHRoZSBjb250cm9sbGVyIikNCj4gTGluazogaHR0cHM6
Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvYTIxZjM0YzA0
NjMyZDI1MGNkMGE3OGM3YzZmNGExYzljN2E0MzE0Mi5jYW1lbEBnbWFpbC5jb20vX187ISFBNEYy
UjlHX3BnIVlXZ0Y2b3FmdVZZNnhzdFptcm91a2pscndBRkVZRVFFOHVqX2lVdTRmZDEwbW5KeEVQ
RzM0NWs3NWRNTExkTkZQOHJUMWxlb2stYVBOa3pfRnVBSjF6eG5tdyQgDQo+IExpbms6IGh0dHBz
Oi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2ZvcnVtLm9kcm9pZC5jb20vdmlld3RvcGlj
LnBocD90PTQyNjMwX187ISFBNEYyUjlHX3BnIVlXZ0Y2b3FmdVZZNnhzdFptcm91a2pscndBRkVZ
RVFFOHVqX2lVdTRmZDEwbW5KeEVQRzM0NWs3NWRNTExkTkZQOHJUMWxlb2stYVBOa3pfRnVDek9H
SVZQQSQgDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBNYXVybyBSaWJlaXJv
IDxtYXVyby5yaWJlaXJvQGhhcmRrZXJuZWwuY29tPg0KPiBDYzogS3J6eXN6dG9mIEtvemxvd3Nr
aSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTdWdnZXN0ZWQtYnk6IFRoaW5o
IE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmFr
dWIgVmFuZWsgPGxpbnV4dGFyZGlzQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYyB8IDEwICsrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdj
My9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBpbmRleCBkNjg5NThlMTUxYTcu
LmQ3NDJmYzg4MmQ3ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTEyMTgsOSArMTIxOCwxNSBAQCBz
dGF0aWMgaW50IGR3YzNfY29yZV9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJCSAqIEhvc3Qg
bW9kZSBvbiBzZWVpbmcgdHJhbnNhY3Rpb24gZXJyb3JzKENSQyBlcnJvcnMgb3IgaW50ZXJuYWwN
Cj4gIAkJICogb3ZlcnJ1biBzY2VuZXJpb3MpIG9uIElOIHRyYW5zZmVycyB0byByZXBseSB0byB0
aGUgZGV2aWNlDQo+ICAJCSAqIHdpdGggYSBub24tdGVybWluYXRpbmcgcmV0cnkgQUNLIChpLmUs
IGFuIEFDSyB0cmFuc2NhdGlvbg0KPiAtCQkgKiBwYWNrZXQgd2l0aCBSZXRyeT0xICYgTnVtcCAh
PSAwKQ0KPiArCQkgKiBwYWNrZXQgd2l0aCBSZXRyeT0xICYgTnVtcCAhPSAwKS4NCj4gKwkJICoN
Cj4gKwkJICogRG8gbm90IGVuYWJsZSB0aGlzIGZvciBEV0NfdXNiMyB2Mi4wMGEuIFRoaXMgY29u
dHJvbGxlcg0KPiArCQkgKiByZXZpc2lvbiBzdG9wcyByZXNwb25kaW5nIHRvIFN0b3AgRW5kcG9p
bnQgY29tbWFuZHMgaWYNCj4gKwkJICogYSBVU0IgZGV2aWNlIGRvZXMgbm90IHJldHJ5IGFmdGVy
IGEgbm9uLXRlcm1pbmF0aW5nIHJldHJ5DQo+ICsJCSAqIEFDSyBpcyBzZW50IHRvIGl0Lg0KPiAg
CQkgKi8NCj4gLQkJcmVnIHw9IERXQzNfR1VDVExfSFNUSU5BVVRPUkVUUlk7DQo+ICsJCWlmICgh
RFdDM19WRVJfSVMoRFdDMywgMjAwQSkpDQo+ICsJCQlyZWcgfD0gRFdDM19HVUNUTF9IU1RJTkFV
VE9SRVRSWTsNCj4gIA0KPiAgCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VDVEwsIHJl
Zyk7DQo+ICAJfQ0KPiAtLSANCj4gMi4yNS4xDQo+IA0KDQpJIGJyb3VnaHQgdXAgdGhpcyBpbnF1
aXJ5IGludGVybmFsbHkuIFBsZWFzZSB3YWl0IGFzIEkgbmVlZCB0byByZXZpZXcNCnRoaXMgZnVy
dGhlci4gVGhlIGhhbmRsaW5nIGZvciB0aGlzIG1heSBiZSBkaWZmZXJlbnQgZGVwZW5kaW5nIG9u
IHRoZQ0KdGVhbSdzIGZlZWRiYWNrLg0KDQpUaGFua3MsDQpUaGluaA==
