Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073D169EF0D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 08:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjBVHBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 02:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjBVHBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:01:18 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66E52B60F;
        Tue, 21 Feb 2023 23:01:14 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M5C83n014367;
        Tue, 21 Feb 2023 23:01:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=JPpWsmJUrudFprMVstceLNzPQnqUWrPloaqXNUYB8g8=;
 b=BieArcOGlR+HmZZwjg9tR7eKvFw2ih5Uc/EZCVXPzO2HR18bS2WVGoJyZZJwliKdKrno
 ALYhn5z5DzpYA50Tdvdx483IduiihRKTmpJpev8AJJbY0I291cAKucOAsHgYVM+aEmql
 swwDY/ckT/1/GJC1VigToBJ6PXTvFnFHYCJIezHOQhivqyoHmDgp2wMDx6ezcji3LPz6
 IJdEB7QpXqGjdm7nhnsP25gB3Ew3aHmaxLyxCeAW9gQV/H3PQP/uNI4gBHhOVAJHrBae
 t/olO8/g2/FouShT1AU1eImDCfYvS+1pupwg6RLGnHhaVE6xPDazxKuT5AisgqyBZD1d 6g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ntxtd0u09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 23:01:04 -0800
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CD399C00AF;
        Wed, 22 Feb 2023 07:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1677049263; bh=To8rahEXb3TPRVdVl+TZhjDL+hvupuhlw9elzPiEq5w=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=HKHnBghJsAc/H/Cw1TtE2OTi/Rl0HLLuu2iQLSsV6Fe58gaFKtoFNb3SJjA1yf5sr
         3hSf324r8ub+eTMZQw56pn2R2O3nhgcFy6xwZ2Gj7DsvHi+3cYMT+zWSM8NSAzcus2
         OOaYjBqCFGebzTGoAwor317zfXZo7A3kLl+DeoxbfY0sQuGliH3z1yRi+CzoncbZyg
         6erdv5Uj8QGiTKU6Q8Dk/dABnGjB7USCucPMz5lMYgz2jDDDC6ZMFIaACQretesOHX
         TOGSXtmCqgpR4TvkmRmB2XOChNy8jnxLhZ5BNBO9FVgnVYlUSN0D0WUhmlNAm1n433
         sXbnT1hemEUlA==
Received: from o365relay-in.synopsys.com (sv2-o365relay5.synopsys.com [10.202.1.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4D05AA005A;
        Wed, 22 Feb 2023 07:01:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 67291A016E;
        Wed, 22 Feb 2023 07:01:01 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="jQuY4FLj";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTb4/gA16K3nRxDWzZMYMScmk0HKUGNoK4nVe9T8vpEhG+aVeNcp4a9Q6wSfPTUoxCtWcqDnTXPAKjseWaaj3njwnPfmLaqCbP0cRZ0jijTBLlHyDf+4UtXCsypJn4ufLHPfF8eOHg05edkPnpu/HvXujWoqHHpGD5/s58ABigkWM6VGS36wmZVKUZOJcMSVgwWMha4Qx7PV2qdL7Jg03bMuLkrCxG/TdTVGRA5OTNN1eaU3BEPJfGylShyCEUCODiDSHagsvUJ+oo1Q8qJUrSiAlnf8EggJj30tdth7lmYPxLyZhjWYG0+CjfYJ41Pcw6vv4LByLzhdYoeixJgLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPpWsmJUrudFprMVstceLNzPQnqUWrPloaqXNUYB8g8=;
 b=ZmjI68nZAQySGXtC2sj3lSorBKZDZH5Cl1eB7wUY2/3mEqVya819zviAhlcD4MBoPICNV4B151rQmoLHZGMMpmy2QobNOvMGwdIBF4suBlalHz1UhHyb/7QxtLpGVYgJHEA6oEMaj5vCTpRrLKdUm7IkACMGZCDCrXIIkEu2FtpTANPEcaTESXku7TdjbeA0iUtpAUDoHPAYNjidO45vntTSwa9TCEqkIsWPnqmhk/G4H0njAkc5fSyrkNyI0yJkuDWGwIdU3d6o5DG8mg4aMGcFb8n3Ul/SdpvINQakkKpcY1jwaiUgah/3v7WqwmDo+BP0wGCyA9qrBVYI9OOPGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPpWsmJUrudFprMVstceLNzPQnqUWrPloaqXNUYB8g8=;
 b=jQuY4FLjjeaKcPZckUgarAZy4rDTfVYwp73x8Rg7ZppRvCfy+ZMdL7ZzJAcqPo/tQfRZMbk+ownuRa0JCcKim3DZOX69m4m69jGz1biNGtDL5IplTYd7u5oHgNhScGi/8n5PFk/iFuXP5U4Q3H73Lfdl23rW3ABpTso4uyzfmeU=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 07:00:29 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::b864:207b:e50f:2ffe]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::b864:207b:e50f:2ffe%4]) with mapi id 15.20.6111.019; Wed, 22 Feb 2023
 07:00:29 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Ziyang Huang <hzyitc@outlook.com>,
        "amelie.delaunay@foss.st.com" <amelie.delaunay@foss.st.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "fabrice.gasnier@foss.st.com" <fabrice.gasnier@foss.st.com>,
        "amelie.delaunay@foss.st.com" <amelie.delaunay@foss.st.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] usb: dwc2: drd: fix inconsistent mode if
 role-switch-default-mode="host"
Thread-Topic: [PATCH v2] usb: dwc2: drd: fix inconsistent mode if
 role-switch-default-mode="host"
Thread-Index: AQHZRd+knSYE4gin9E6iCq3Lba7rya7aiagg
Date:   Wed, 22 Feb 2023 07:00:28 +0000
Message-ID: <BYAPR12MB33996D70422B24DE982F3B4AA7AA9@BYAPR12MB3399.namprd12.prod.outlook.com>
References: <SG2PR01MB204837BF68EDB0E343D2A375C9A59@SG2PR01MB2048.apcprd01.prod.exchangelabs.com>
In-Reply-To: <SG2PR01MB204837BF68EDB0E343D2A375C9A59@SG2PR01MB2048.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcaG1pbmFzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctOTU0NWIwM2ItYjI3ZS0xMWVkLWIwNjktNWM1ZjY3?=
 =?us-ascii?Q?NjdkNDhiXGFtZS10ZXN0XDk1NDViMDNkLWIyN2UtMTFlZC1iMDY5LTVjNWY2?=
 =?us-ascii?Q?NzY3ZDQ4YmJvZHkudHh0IiBzej0iMjM4NSIgdD0iMTMzMjE1MjI4MjY4NzM4?=
 =?us-ascii?Q?MzQwIiBoPSJOWnhJTU1EWUtLcGNqb0dnczV1ekdWd2gwTXc9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFIWUlBQUFr?=
 =?us-ascii?Q?ZDZGWGkwYlpBZFM3d0dhaSt3aEkxTHZBWnFMN0NFZ05BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFBR0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQTJXMC9vZ0FBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdC?=
 =?us-ascii?Q?aEFHNEFZd0JsQUY4QWNBQnNBR0VBYmdCdUFHa0FiZ0JuQUY4QWR3QmhBSFFB?=
 =?us-ascii?Q?WlFCeUFHMEFZUUJ5QUdzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FYd0J3?=
 =?us-ascii?Q?QUdFQWNnQjBBRzRBWlFCeUFITUFYd0JuQUdZQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJnQmxB?=
 =?us-ascii?Q?SElBY3dCZkFITUFZUUJ0QUhNQWRRQnVBR2NBWHdCakFHOEFiZ0JtQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFHOEFk?=
 =?us-ascii?Q?UUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBY3dCdEFH?=
 =?us-ascii?Q?a0FZd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3?=
 =?us-ascii?Q?QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QnpBSFFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdC?=
 =?us-ascii?Q?bEFISUFjd0JmQUhRQWN3QnRBR01BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4?=
 =?us-ascii?Q?QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFkUUJ0?=
 =?us-ascii?Q?QUdNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHY0FkQUJ6QUY4QWNBQnlBRzhB?=
 =?us-ascii?Q?WkFCMUFHTUFkQUJmQUhRQWNnQmhBR2tBYmdCcEFHNEFad0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBY3dCaEFHd0FaUUJ6QUY4QVlRQmpBR01BYndCMUFHNEFk?=
 =?us-ascii?Q?QUJmQUhBQWJBQmhBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpB?=
 =?us-ascii?Q?R0VBYkFCbEFITUFYd0J4QUhVQWJ3QjBBR1VBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhNQWJnQndBSE1BWHdCc0FH?=
 =?us-ascii?Q?a0FZd0JsQUc0QWN3QmxBRjhBZEFCbEFISUFiUUJmQURFQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFjd0J1QUhBQWN3QmZBR3dBYVFCakFHVUFiZ0J6QUdV?=
 =?us-ascii?Q?QVh3QjBBR1VBY2dCdEFGOEFjd0IwQUhVQVpBQmxBRzRBZEFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?MkFHY0FYd0JyQUdVQWVRQjNBRzhBY2dCa0FBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3399:EE_|DS0PR12MB7927:EE_
x-ms-office365-filtering-correlation-id: f3958752-f44f-4145-00ef-08db14a27b52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 55OquVsMMqVlGtK27Bvo3lju6UIGhDnu/SetSAzPuveO50BExaU48N1f4kXwuIYJbIE96RV+y3rlzE0F2f0f8C7l8kF1PlEFrg/MwWOL0qQo/4xpV3vZwZ+TNW+pJkwNqGDa1kduBZgdQ3hWCPNIuBWOIUNbjAw4+Rf4ZJVH4AwJ0Pu3mX1xGQRcb1bQpZe2bYP60R9fS7jympWAJB7rL8AWdr7s7QKeUMXtzQkGhipWUf9i1EItEzCqtXPq81FLttrzU4EXpv5RFu95z8NBIGSP6bytfDFx8JGp/mA4xlyGGbhNDD4qdpSVu0H98oqQMHo9aX5WNRQJ/kWnFghU5TRg/kLBwl2NWDz4p+h6ePllPJKfXG722x6QzpglTvFO0z63CE+R1JgSfmH6T3fMMh5fUmKglUUSiHndQROijwVbsa3nelOfBTpk17banpKsZlFFmu2KsW1/Wguw09arwF2w7+rnkEHCjNL/vcslQbl7uWI2RbqNdhIyZcn3fcuM0zG04eTpfJxtFAPyJtx8/29Leg5luhcluFao8vUZzuGVv50VZjuW/RPEd2/vLojBxAG0ib9dMOIqVezXU9Znmh7K0N6sM1O+oqy9cPm9quzAfvHSoA82qyWI6IA1oFKXPaArDr8iTf6941rDebjIsqpvcr8Yjo6BAj2Joi9XCRKJ+5fA6y1tASvZ+YLL6uiiC0inWHYi87RWhHOmxMNFvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199018)(122000001)(38100700002)(41300700001)(110136005)(316002)(54906003)(76116006)(38070700005)(53546011)(6506007)(26005)(9686003)(186003)(33656002)(55016003)(478600001)(86362001)(64756008)(8676002)(66476007)(66946007)(66556008)(4326008)(71200400001)(66446008)(52536014)(8936002)(83380400001)(7696005)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y5Zk/GL188fkINAW6r2PehzaoX6EDdEJb+FHaGCyJscsaQshP8YQlnXv2QpO?=
 =?us-ascii?Q?g7I5gS3IYS9qFvSSm4m86X268Li/BdZgrg57AjLakHhNbZu9w6+9yjHyekzT?=
 =?us-ascii?Q?b353kcUXnK9vjI2Jc3F/rG37odf2OCcVaSBMkGF/Aihtw0r3M7ynv/w2wXqc?=
 =?us-ascii?Q?i2r+IAa8knRnCnU8NoYGssCqB2IBDOevkBs2tP5EHcCrHgTrDMTsVdXHBE8r?=
 =?us-ascii?Q?6y4djWdkwWU//SAIumNmGO8SGBA8A7CRbJWc1IZTkaUDqPh+SYR15TjKMzOv?=
 =?us-ascii?Q?LpS1Ipg8m/0QvEN7TaYDwoNNLE0I/ZcXp6ygtuFEc3BeLcXMTYzo7ldyYUzP?=
 =?us-ascii?Q?rAuAynz/gg6YtrQH/n9voTL4izI147kEy9bEFIXglvBmYjokdhaDdBXR3jye?=
 =?us-ascii?Q?AJCzHtDoOWYZZ8E0UYORsojDWPVc7uLZiXIzdPtKHOO4gGpiV0jyVVpE8v7U?=
 =?us-ascii?Q?zTwzC8UR2I2Rl/8SBqLJNLoB0SA8wiK5Dw8LWtSrS9DggNpQATR2J5TKy4p1?=
 =?us-ascii?Q?xbenIWmVPBVCQc3bGqnKbpIwKc6Kn3OYk5Dki5hLl9/ajk2q2Wg/Ve30Ael3?=
 =?us-ascii?Q?w9jps1mexRSy2vVdKBa/G2PjLom0/Hb8tsPSZTLhuUoBAbLLctP5VBR4LnfC?=
 =?us-ascii?Q?SI3YrwWCMrRmtOIbg/JDamkM43y36Urfwp0Xc+jLJDA021ZEblJfHRyXgM1o?=
 =?us-ascii?Q?FHx/BrbodfKX801Yn/FkDp52J9BjwGIOUg2/OhoPDNaEYz+O4bgKA2yIgkFX?=
 =?us-ascii?Q?soeFiq/Dn6c7nrCWNaI3mj/JTlMCvfpbADIhmGBlSiljLZDSfQrbDGxU3Dzu?=
 =?us-ascii?Q?M1yfIMQ6jtrGCMpla2U2fWoOd0lnQ4gS5FH8zjU3zcBtHm9tzcTmFoaae+OY?=
 =?us-ascii?Q?UHGVP7e9dsAHAg8Rx8/7pHPXWRt149BaMtb0o25KScqHV5V5IBYWcB58ZZFt?=
 =?us-ascii?Q?Bm3A4QvD+wQzCg+GsEqvY8LkVj92AN0QBViTXAdkJ3Sy1BEdh3nm6b3bclDG?=
 =?us-ascii?Q?gzTfJgtX8l4XoQU5oTzewRsHWFihFpMYSRGV7xntF0InKOZUpjLoZLZHlAXi?=
 =?us-ascii?Q?ua0KtQP1k4xc7/DUuJSgHvOkzNAi6WKU9IvBwqAIx3gjHfIsOZw4sFMq1/Q1?=
 =?us-ascii?Q?nXzZUckRbu662aRZxOOSNtGXZdxoUFYaVz2C882v3k8g4RP2TgvCswEZIsya?=
 =?us-ascii?Q?VRfV8hF9eW9uZzuKdS+9t6OMtGxvwlJLHoNIe8mbekG4KCXvR/YCBK9Twg4f?=
 =?us-ascii?Q?TLqZ58CUq8qDRwKFdJWckuumL/TE3ttftIaISzMKo2pEfmcTK5igdYT3DaAX?=
 =?us-ascii?Q?S3ba0hkwe7AFC6FztRE/uP7pZKOpuKtvUv0u4j9nQ3+BtMj5B6qLquZQWkHt?=
 =?us-ascii?Q?Cd6pJboPe1ja91Dc9Odov0Y0EhIfWSaw5IRLQyQImvyCnvdg1mZk3NeDxGpl?=
 =?us-ascii?Q?g569ndxkcyS3t/wVrzJO21kJfuInLwRNdvr0gXDcaG8rQPQz21sOEq4Mn953?=
 =?us-ascii?Q?Nqn4LpISWZv5ALp5BJJmTlhU1Au3V4Xb6plAVGpu3xo27HVZ7uZVkWIRQZiI?=
 =?us-ascii?Q?NbjLmFD9zXYMsSknamdNL9I/j+Y5T6jCG9kYIoWd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: glz29UAy31B1RT3/0C+fjarNwN2bkAvkJ1IkB3gLTpXc5BQGcveXjYOs2CPaFfQeWzppKKdJ2cokBdue8YMHG/lbKskOTgSaFWL2X7busin3SoOWtdd4B5gXp1En1iUFAwx51ySJHynOJfYkb0TF9VTfTAuaicFATREPOYeVY2+Z5NpCzzLqZgLbLCnMHsT/yWFspHvumWlKP/i1JPijTPpzxMl2d48kK/EtfyVtLxgLLqCuU9CU9CleKb7Cm4lxYNf8k4cycOR76aRmrXNw2JCcemSc9o1si9UsL12X+qmnCfhvyX7ueEd3wbzAYogc0F2FXNyLDuLzvIixzEBSHhxlvbaPkj8JcA6MsFNNr+E8cJ75efvPJobPro6g5qE6ILC4hBCwYtfi5RRi55AWLqwC1FwlfoYQToY+INgiCCkbUDAT/pjhivB/4b78SikRsL9lnWB4Ft+rMssH/duazkZ2KbwCBQUtj4nFR9CmQuCn+GH4oC2+dR5KT3+v+6UTHqhG101ZeiryVQuCISCBZfzKukc/x96iWkZeh7YvWQpAcIkj5e3UvfC3dT1nLeHQUDVIDLLSkPERxCA1SQJV1C6RCO4nRbYcOWPRvkI+z9hmpMmXqZ0KK37DjWG6v2Wn/tw2xbu1fi5W8t0zjd7MYswgc00tp5P8HXjcHgzvcexeUr5KpkvV7vDdC5KKebe3wV0N434MBWmWahwai9TsPbT5FLm18GbRReraGxF++qDOsBe2Fe/IQXYriGyZTiLUFYo6/dYErW+uhD86HukM5urX931SNPFIYs8dqv+f09oStJvONKC31gDRtbycOclbnJrHiAURXK5497yuOhRjom8izkM4GR47MsHAIm7o+vr5jr3o0/HP8ijoq2HJN2li6smXFdsiCvp31NO2pyZivt/4gw3WaTmY/P5Bc/AKhCg=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3958752-f44f-4145-00ef-08db14a27b52
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 07:00:28.8973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 81pQ9bgOh35LtFJIdvFummp3ycvLi7jWXyl+T481J9fmafnb9lPnON1AVLuEhTPG584UZG0h3+fOCPJ0OkK7Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927
X-Proofpoint-GUID: NvfjtlooI6jIXRPGEZdW-m3GKPLVO5ey
X-Proofpoint-ORIG-GUID: NvfjtlooI6jIXRPGEZdW-m3GKPLVO5ey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_02,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amelie,

Could you please review and test this patch on your setup.
Doesn't broke anything.

Thanks,
Minas

On 2/21/2023 2:30 PM, Ziyang Huang <hzyitc@outlook.com> wrote:
>From: Ziyang Huang <hzyitc@outlook.com>
>Sent: Tuesday, February 21, 2023 2:30 PM
>To: Minas Harutyunyan <hminas@synopsys.com>
>Cc: gregkh@linuxfoundation.org; fabrice.gasnier@foss.st.com;
>amelie.delaunay@foss.st.com; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org; Ziyang Huang <hzyitc@outlook.com>
>Subject: [PATCH v2] usb: dwc2: drd: fix inconsistent mode if role-switch-
>default-mode=3D"host"
>
>Some boards might use USB-A female connector for USB ports, however, the
>port could be connected to a dual-mode USB controller, making it also
>behaves as a peripheral device if male-to-male cable is connected.
>
>In this case, the dts looks like this:
>
>	&usb0 {
>		status =3D "okay";
>		dr_mode =3D "otg";
>		usb-role-switch;
>		role-switch-default-mode =3D "host";
>	};
>
>After boot, dwc2_ovr_init() sets GOTGCTL to GOTGCTL_AVALOVAL and call
>dwc2_force_mode() with parameter host=3Dfalse, which causes inconsistent m=
ode
>- The hardware is in peripheral mode while the kernel status is in host
>mode.
>
>What we can do now is to call dwc2_drd_role_sw_set() to switch to device
>mode, and everything should work just fine now, even switching back to
>none(default) mode afterwards.
>
>Fixes: e14acb876985 ("usb: dwc2: drd: add role-switch-default-node support=
")
>Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
>---
>Changes since v1
>- Use corrent name in Signed-off-by
>
> drivers/usb/dwc2/drd.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/usb/dwc2/drd.c b/drivers/usb/dwc2/drd.c index
>d8d6493bc457..a8605b02115b 100644
>--- a/drivers/usb/dwc2/drd.c
>+++ b/drivers/usb/dwc2/drd.c
>@@ -35,7 +35,8 @@ static void dwc2_ovr_init(struct dwc2_hsotg *hsotg)
>
> 	spin_unlock_irqrestore(&hsotg->lock, flags);
>
>-	dwc2_force_mode(hsotg, (hsotg->dr_mode =3D=3D USB_DR_MODE_HOST));
>+	dwc2_force_mode(hsotg, (hsotg->dr_mode =3D=3D USB_DR_MODE_HOST) ||
>+				(hsotg->role_sw_default_mode =3D=3D USB_DR_MODE_HOST));
> }
>
> static int dwc2_ovr_avalid(struct dwc2_hsotg *hsotg, bool valid)
>--
>2.34.1

