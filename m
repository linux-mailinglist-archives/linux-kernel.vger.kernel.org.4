Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5E26C76D6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 06:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCXFJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 01:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCXFJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:09:29 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0750728E5C;
        Thu, 23 Mar 2023 22:09:28 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32O4wPqq015614;
        Thu, 23 Mar 2023 22:09:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=1uoWxsJzIV8viah986PxlIQyv4ISumFen3M4Jn45mGM=;
 b=SaoAtMjrbiT/0CzbuW0ZypB3VWknqK/vPalJUEpD/QHNjuokkt3IMYnWbtIQAdzCiA01
 83mSePn9nrm6cKi1D1Ta/oSGRsfCEDhEGl8NSNZDs6heq0lXIIX6nO9I5nWUbTA7qpbA
 mRy56p2D4sTx5KuJ4V7AQtTutVYJHg47mxdqeuzy1+1PuOtoEQU+9KeLFWiDWpQbp4Rn
 vSlcfDxEX1aHcLRFX1JUjUYrnFasS7XhGurtfcjbdQGsSPq8ZOQjzdlYDRVPOGQPe+pv
 JE8j6Gh50M+hRzyH/qQPDSdZFpo0CnLQGOQedR8UFu9LF29SNAP8GsAd12XdFtfQLUd9 XA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pgxtn1mqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 22:09:15 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 019CAC0445;
        Fri, 24 Mar 2023 05:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679634555; bh=mT8x8gJtQ0+nywoSVbv7bAUxi6kCiihQmeyMyja8+Ho=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=G06/sJYQp5wZ55cyhfRhqPAz+xnbizzE4ZqWZ0f0QUp0LTZAGVHVdtyOFxCEEEqsP
         1GbSwxDIUUyhnA6vYJUfmtguqZRj+7Jfc2Jtz4WI2PIm4xn1T8eDwobSNGEs8vWvQy
         p224NslVCmAJ44RlMF9YI8htrLM4fiQkwWeL1GSRt5fANfYRjF4SXW0Xot0GgjkOF4
         HiKSR0JuQ5GF8J/GoRLgU28+o+ERpXaoCPVhbPhVx1R1+aGjNkIq0oabppTJIXd+R5
         id9zL/q2M0lWHFmHkNolzUkR/BUFS27xS31Ta5amCgH1akRTiG9HKP2LvYJvirTTRg
         y5/YKlLv8iERQ==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D6CBAA00A4;
        Fri, 24 Mar 2023 05:09:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id EA8AF800D4;
        Fri, 24 Mar 2023 05:09:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="M7pd3VHR";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYqY3RFKCfWO+Jr6cib+4fi4hUTxI7AlfPLZ2dkk5xOprrlV3RrOPQ1SJVj+6HVd688teiztfsYF6Pko5WB2xhFXnbT41/119lIuhq1i0qfrYoOZA867BD9HMl/pxK3sVw5EMBQg8d2QwflLZqKLw1wPhplVSJvJNIfOBDdu2g16WmwuZRHxamallARDqE5WZ8MMqKCmZDmgUdvNNb1JDPk/MCFb1CJHUHiYttwZs8K7FdS51h73xYhRBIw4VSZ/123XVDHvUhpnsvzQDNXp+RH5h+8aUXR4JTOoNVbWPyJBvenk4WJ8CxlCQ5fqiOH29GKYnW5bOLZ45Sp1tjwplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uoWxsJzIV8viah986PxlIQyv4ISumFen3M4Jn45mGM=;
 b=HXRjirAG8PI+EqVtPJxcpOGwMuzQgX3KFJUKnIceWjlDgD8CivsETWRR6V6tnXFAGG2ZwD9W/dtNgLrrks8Rh1hWd2olAb6d7u3plukmrgGqH1ZacWbGYBzNvPMgP6C6pRqRLbwPGyVONh3kScvTWFOlH+b9ZVe7JYK9mZ6S9fXH9/BAKLtINiCpwt/7HctUAFXpAGiwitovkp1CHfyMi7ai/28aBJzR/T5hz5AfBQJigp7drywIGQWbkE4n6bBSrkH7wc0yGrK4w+ezdEUlzBhJK3uhN/pK0ZWbA5FsnLlT1IYqRaRTnlk0zuejYxGARDxrxBMHpFTDsEw4yjqvEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uoWxsJzIV8viah986PxlIQyv4ISumFen3M4Jn45mGM=;
 b=M7pd3VHRS+adkhK5tQfO3gCc0VQXpd4wd8tLJlqzvTQq1rTlrlNxQIOVR9rgi1MMnoqA+eVLUWTxbfbBw3ukE/zvvIZufQG1udKN/hMAq5MUP1A6HzkxPaWfJFced1iHyjE1b3P2/E/PoAzl2QL52pKEESS+FE+y86yFiDDncxo=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 05:09:10 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::b864:207b:e50f:2ffe]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::b864:207b:e50f:2ffe%5]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 05:09:10 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quentin.schulz@theobroma-systems.com" 
        <quentin.schulz@theobroma-systems.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "amelie.delaunay@foss.st.com" <amelie.delaunay@foss.st.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>
Subject: RE: [PATCH] usb: dwc2: fix a race, don't power off/on phy for
 dual-role mode
Thread-Topic: [PATCH] usb: dwc2: fix a race, don't power off/on phy for
 dual-role mode
Thread-Index: AQHZV0y86Vo9MmsmT0qa2vDc2LUTSq8Jbprg
Date:   Fri, 24 Mar 2023 05:09:10 +0000
Message-ID: <BYAPR12MB3399A285F4DAF09F2AB18DACA7849@BYAPR12MB3399.namprd12.prod.outlook.com>
References: <20230315144433.3095859-1-fabrice.gasnier@foss.st.com>
In-Reply-To: <20230315144433.3095859-1-fabrice.gasnier@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcaG1pbmFzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctMDA5OGQ4ODgtY2EwMi0xMWVkLWIwNzItNWM1ZjY3?=
 =?us-ascii?Q?NjdkNDhiXGFtZS10ZXN0XDAwOThkODhhLWNhMDItMTFlZC1iMDcyLTVjNWY2?=
 =?us-ascii?Q?NzY3ZDQ4YmJvZHkudHh0IiBzej0iNTEwNiIgdD0iMTMzMjQxMDgxNDc3MjUy?=
 =?us-ascii?Q?MTUwIiBoPSJ3ZFZoTytkNTFmdlFoTGN2NXNTOG5xeS9hNFU9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFIWUlBQUEy?=
 =?us-ascii?Q?eFBEQ0RsN1pBY05VcGpicHVlaVZ3MVNtTnVtNTZKVU5BQUFBQUFBQUFBQUFB?=
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
 =?us-ascii?Q?a0FZd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lB?=
 =?us-ascii?Q?YndCMUFHNEFaQUJ5QUhrQVh3QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QnpB?=
 =?us-ascii?Q?SFFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFl?=
 =?us-ascii?Q?UUJmQUhBQVlRQnlBSFFBYmdCbEFISUFjd0JmQUhRQWN3QnRBR01BQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJtQUc4QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRB?=
 =?us-ascii?Q?QnVBR1VBY2dCekFGOEFkUUJ0QUdNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?Y0FkQUJ6QUY4QWNBQnlBRzhBWkFCMUFHTUFkQUJmQUhRQWNnQmhBR2tBYmdC?=
 =?us-ascii?Q?cEFHNEFad0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBY3dCaEFHd0FaUUJ6QUY4?=
 =?us-ascii?Q?QVlRQmpBR01BYndCMUFHNEFkQUJmQUhBQWJBQmhBRzRBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpBR0VBYkFCbEFI?=
 =?us-ascii?Q?TUFYd0J4QUhVQWJ3QjBBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUhNQWJnQndBSE1BWHdCc0FHa0FZd0JsQUc0?=
 =?us-ascii?Q?QWN3QmxBRjhBZEFCbEFISUFiUUJmQURFQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFjd0J1QUhBQWN3QmZBR3dBYVFCakFHVUFiZ0J6QUdVQVh3QjBBR1VB?=
 =?us-ascii?Q?Y2dCdEFGOEFjd0IwQUhVQVpBQmxBRzRBZEFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCMkFHY0FYd0Jy?=
 =?us-ascii?Q?QUdVQWVRQjNBRzhBY2dCa0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3399:EE_|SA1PR12MB6946:EE_
x-ms-office365-filtering-correlation-id: c2025573-3d61-4813-3756-08db2c25e6e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O64Ow/W/mSvo3fzxxOp2MksLQqaItbFjSG9iMqdQSw1eGd2bBiTrWqK5EIs4gx5GXpM0m1YeWZ4T+TbeTFG2P16x0j7IjBPs33peqIIDxnuHaLwG1zPsYngaQ+XJoXz/Q49+F+za0+kQTCcA+SJ6pdG2/sLXs5RXXEoOyLUv3AQVcdSMGC5VPBf/f9KzjmoZUpErn2IyGjbrVxw7BkEq2p35NK87W3Vx9EqtOZZia3+33lP8DLNYdsJnsBNLPO2JPeo+Ig8hF80OCEPxN3NnfdXsCx3qjUDSTTEGzLSoQO6XWKxJFrybFU6L8IFBqi5GgzCiPD3MuJ2fMdObYsmvVR+Gr36YMB9SlWK91xutmk9eP69zRzC8TN+f12PdY28J42I6KKtfpO+vDZw3qFAR7MzaXn5LVW4vG+zOmeHTR+3RcnP121ew99PZ7xeB0f9wJVALS42A975atQEaACtiIbVHUJmqydEVW+AWajyFan++YqbEbkDEUZKsJNGKBNDrqAnuLosqNB/B2FITE4XT+GmZ+DLp6oGqG1jRTMCoFjFXz2Nd6JwwkxJLy++GtAojdLs9B9Dz89qg8ZaPdoMqKIhbThmryn+Bjw6nbfbSS1Ckj24IDmUIDredm/5h3g8Mr47m38hr8Km10orE+Zx32oevnL6FIXNhvAtUY4s15TE2LS2L3RZcdq65qphv7u77
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199018)(64756008)(4326008)(8676002)(76116006)(66946007)(66476007)(66556008)(66446008)(52536014)(8936002)(33656002)(41300700001)(38100700002)(122000001)(186003)(83380400001)(71200400001)(55016003)(86362001)(38070700005)(6506007)(9686003)(26005)(110136005)(54906003)(966005)(7696005)(478600001)(316002)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H4J2RVDrTBEFK4TAjARuVlAIt84hzVByapC/Yn8rG0BR7v32+iikz3z5aV6p?=
 =?us-ascii?Q?zRsrock7AYUMbC6v08+pn+OwcRRceEsUdum2JpRONt6zrqwfXwruu7kcWcy4?=
 =?us-ascii?Q?t8BBEfrBCXSaMGYCNJahechreoiCp6JUDeTAs/BF3H57ArZ1ZPvZfdDV9VG6?=
 =?us-ascii?Q?wgwq8NwqCYuS1XeRT10L3j2ysx0F/KLZLWS6NPqgq7U+KJVaQm1dI3N+AG8X?=
 =?us-ascii?Q?K+Ghvr+0GTGJIVmaLymuq5w2P5vlsPXWaLbZ6kEHfsFY6+ls4TI9KDUzgpaN?=
 =?us-ascii?Q?gIkex+KlD3Ow9rJXb7SB7xtvp6NsCS3zk9b8b15OfjQHgWrh40MHlY4Alcc3?=
 =?us-ascii?Q?v8Gui4v3P0qlCRC9GStQceXLej/KSu7y45TVTsx5l6/xmz4VkpeLksLEK+VK?=
 =?us-ascii?Q?xXh51gbxvxLx909zeAEiQrnj+6nQ0ehmAebbq+hn/fJbYcGwc9QVwTQhWE6e?=
 =?us-ascii?Q?VK8hwzzNrB5ks3I18LBRgXp7SYNwpRSzgMklFF4jWvDAM5JN9vqvSe4nI2dF?=
 =?us-ascii?Q?CEzG47Os6lctFeTIlXaSl8zGB+pZewBh1yGkWKKlBhaDjqYoNStoLT0IkV4y?=
 =?us-ascii?Q?OuHhR+zdltJPnNwZiZMAZyZhD1rY4JmCRczxBDUvvuQQXo5KcCHIL5QUUcCx?=
 =?us-ascii?Q?rmJIhWb5yHlRLSvWYB9r+nFJ1y7RgE4Ofb++jXIhoK+EQ6qUnvFnLBjziOle?=
 =?us-ascii?Q?FYv3AFOe4hAKcf61JjoZxsFlescA0dvOi070Sc2bQ7Zskx90GwtEsPVZ4DEc?=
 =?us-ascii?Q?jLGB4cYLQtAg1/+Pvh5OUhtpJduTThK7yeOCWH21wKznT6d30wzvDnB1ylPz?=
 =?us-ascii?Q?taSQts+/yPptzsqxzMB9jnR4OkypN5M83P9kFA+DsyLpGnUpqadKISQfQ/3x?=
 =?us-ascii?Q?CGUwdpW9rEIcELaHDGrzhAtojgi2yCzSdWl57tacZYEAgxV5bPnSMWSwomIn?=
 =?us-ascii?Q?CjcxVJkcL3BbwYrgdri1PuRku1gMCFy1xYqe+AJpN8hzD6ILES1Se09xqPhJ?=
 =?us-ascii?Q?vxCdqzBFb5yjnViPdNJ258hUo8qXF/JIwlBO4lhodYTjxdf+AxwujJlccvhQ?=
 =?us-ascii?Q?MKPHp3RLnH2G5O55MfayXl/5JGBbG5IZ1hMW9tb8ijN5zxehJIMp7KgQwA2d?=
 =?us-ascii?Q?j4vd8B5O5WFuF6tc1EWHO2GuFB4HoNL8PWtxmyZ1ss3JJBdO1n0P5O5FT8E8?=
 =?us-ascii?Q?uJ5/78TMR2FkuixCoGmwOlSxSr8j3AoBdxiJkufZqO8/vOl2RhxdItKO1RsU?=
 =?us-ascii?Q?SCTyIEZXG9voe5GG2DbAWDzIzNpKoRrE/V4HObPszJ31/Rrdwrvm508iag3I?=
 =?us-ascii?Q?7pJe4Bg8i5Hyk2usy30Tib/Qn0o5m3bfsgTNB2K7igL6A7meIKNkI344oeMF?=
 =?us-ascii?Q?bIvqDBZNMSQAiEo72h1LjF3BKjFTg+PHAl0wZHD1lFkE6qRpWW4Pc6UrGq0R?=
 =?us-ascii?Q?UCNsNduI8+OpMTj3Y5wo+nG2B9nxqLFXM4eqdLFBM/NRBOFc83htWA2kQOfC?=
 =?us-ascii?Q?XuDVdZLetVHj7iGLeD9Gcswu/yO0VBvW8ZIOCcO+KwuFihywKMyNnFOkVmMr?=
 =?us-ascii?Q?hAj72sjhZ1D/NBoLXNRs7kPN46Y/gmd97xDkwRb+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?E79K2NXS9uQ0/WvAwUBNz3t4qbvorOQYpfJNIlqDl7fZ1+OJAmx5G8OsJkV9?=
 =?us-ascii?Q?0RbwQkdbOzHQTKH04Jlb2BFd1W9+LrkoI+g4u8GO/mDrhXeeTeG2vJsoc8Xi?=
 =?us-ascii?Q?Tar2DxBTKDL/8mCegToDHIt7hROqR2V04+vv9pCrU6Ish4GL+t1a2CfbFSHX?=
 =?us-ascii?Q?oMA1bkocB94PiOozhWtMW7xXKuY7ZBzhW1E+FrUxNBqXno2h2SEulTNdTSJo?=
 =?us-ascii?Q?Lpx0RSvTpmvRl1/wjjGITO/BiQxH/feJhhQAR8WGGNfjjIji4XWydz7XifJZ?=
 =?us-ascii?Q?9QWX1kSfCocgAR2RDdAKHSr0YNOtXojVybx+yobOc9pHi/BleOGZ8MDlMXKF?=
 =?us-ascii?Q?rjrZkU4fbEoxNfs1ooTrCRCoYH/xS52mMHw0h2u/XS9phkpARN/b68yUvoq1?=
 =?us-ascii?Q?8J3bOHzVcxmU4kvGQ3SamXLsTWOw0+ykd1/hEOVRid6TvZdWEjvW3TRaWuCc?=
 =?us-ascii?Q?/XMcp63kQJAk4eRFn2sWtZ4x7HHywJEdVA5Lb1nvHigL7IUxdylA/NGye/Yr?=
 =?us-ascii?Q?OV0mogNSx1o1PZ6k/IycoX7t34nvtSsQOHxUuvEEYPC2hpctqkcXNMNyyhL1?=
 =?us-ascii?Q?OSkN2mUHwowdLWMMmR2c1Dmg4gwoRaMG67fY4tBQU2r57SXyZvh/1WPfGuBu?=
 =?us-ascii?Q?moxgQRY0SeCRpMhuuz7EqpgSl+fwdfxuE6+eMp5ebD0d1WFlZtg7Sdh+bcmB?=
 =?us-ascii?Q?zNiLeXA30rCwNFCsWvK+o0+Qnk2mk5zyzpWXZ30inK7URYppcEdXs5jaV6fr?=
 =?us-ascii?Q?bMQEqGNFF/Eytza4lUEmkdbBvJIokR+f+1tVfgeTaw3auFJtJl2kva34x/m9?=
 =?us-ascii?Q?LHnWiYm78vnBGm/7jn7O4zwGjkJ8V3eC5wEEdLgKFGj1JBfi+xWVtqbU71Uv?=
 =?us-ascii?Q?9B+adq25R9HiJzskhkg0M9uyayo2yfZtFBMfB2kCKa5L8fMrZlxiKcNAYpqM?=
 =?us-ascii?Q?3JuYto3VnucPARsrJ8b2Zss+17J4wy9kTOYAiPLzzXh3W05pYbDp3utEW6mU?=
 =?us-ascii?Q?86UO+TZO3SngmhfFQNSTX2woxg=3D=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2025573-3d61-4813-3756-08db2c25e6e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 05:09:10.2134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYiyzAlmRG04HHDB216U4fLvPkXOILq/qI2tMwzM5BLRn0/UPNKXq5EX5LjrrWFNwdFK0EEkcon2UR6oWjvI+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946
X-Proofpoint-ORIG-GUID: vMdVOJuvu2jT1hkEmTZZxzeENAB8WcVb
X-Proofpoint-GUID: vMdVOJuvu2jT1hkEmTZZxzeENAB8WcVb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_02,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 clxscore=1011 mlxscore=0 phishscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2303240040
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice,

>On 3/15/2023 6:45 PM, Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:
>From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>Sent: Wednesday, March 15, 2023 6:45 PM
>To: Minas Harutyunyan <hminas@synopsys.com>; gregkh@linuxfoundation.org;
>quentin.schulz@theobroma-systems.com
>Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; linux-stm32@s=
t-
>md-mailman.stormreply.com; amelie.delaunay@foss.st.com;
>alexandre.torgue@foss.st.com; fabrice.gasnier@foss.st.com
>Subject: [PATCH] usb: dwc2: fix a race, don't power off/on phy for dual-ro=
le
>mode
>
>When in dual role mode (dr_mode =3D=3D USB_DR_MODE_OTG), platform probe
>successively basically calls:
>- dwc2_gadget_init()
>- dwc2_hcd_init()
>- dwc2_lowlevel_hw_disable() since recent change [1]
>- usb_add_gadget_udc()
>
>The PHYs (and so the clocks it may provide) shouldn't be disabled for all
>SoCs, in OTG mode, as the HCD part has been initialized.
>
>On STM32 this creates some weird race condition upon boot, when:
>- initially attached as a device, to a HOST
>- and there is a gadget script invoked to setup the device part.
>Below issue becomes systematic, as long as the gadget script isn't started
>by userland: the hardware PHYs (and so the clocks provided by the
>PHYs) remains disabled.
>It ends up in having an endless interrupt storm, before the watchdog reset=
s
>the platform.
>
>[   16.924163] dwc2 49000000.usb-otg: EPs: 9, dedicated fifos, 952 entries
>in SPRAM
>[   16.962704] dwc2 49000000.usb-otg: DWC OTG Controller
>[   16.966488] dwc2 49000000.usb-otg: new USB bus registered, assigned bus
>number 2
>[   16.974051] dwc2 49000000.usb-otg: irq 77, io mem 0x49000000
>[   17.032170] hub 2-0:1.0: USB hub found
>[   17.042299] hub 2-0:1.0: 1 port detected
>[   17.175408] dwc2 49000000.usb-otg: Mode Mismatch Interrupt: currently i=
n
>Host mode
>[   17.181741] dwc2 49000000.usb-otg: Mode Mismatch Interrupt: currently i=
n
>Host mode
>[   17.189303] dwc2 49000000.usb-otg: Mode Mismatch Interrupt: currently i=
n
>Host mode
>...
>
>The host part is also not functional, until the gadget part is configured.
>
>The HW may only be disabled for peripheral mode (original init), e.g.
>dr_mode =3D=3D USB_DR_MODE_PERIPHERAL, until the gadget driver initializes=
.
>
>But when in USB_DR_MODE_OTG, the HW should remain enabled, as the HCD part
>is able to run, while the gadget part isn't necessarily configured.
>
>I don't fully get the of purpose the original change, that claims disablin=
g
>the hardware is missing. It creates conditions on SOCs using the PHY
>initialization to be completely non working in OTG mode. Original change [=
1]
>should be reworked to be platform specific.
>
>[1] https://urldefense.com/v3/__https://lore.kernel.org/r/20221206-dwc2-
>gadget-dual-role-v1-2-36515e1092cd@theobroma-
>systems.com__;!!A4F2R9G_pg!Y21e8pRbIOVyLQTRP5HjdeDUHpSjbtiRQVFGVCOBBDu9yH3=
2W
>tdppqmP-8TLyGrBjyOBG5iI4qw6XMFEdfRJDhZ8HVc$
>
>Fixes: ade23d7b7ec5 ("usb: dwc2: power on/off phy for peripheral mode in
>dual-role mode")
>Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Acked-by: Minas Harutyunyan <hminas@synopsys.com>

>---
> drivers/usb/dwc2/gadget.c   | 6 ++----
> drivers/usb/dwc2/platform.c | 3 +--
> 2 files changed, 3 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c index
>62fa6378d2d7..8b15742d9e8a 100644
>--- a/drivers/usb/dwc2/gadget.c
>+++ b/drivers/usb/dwc2/gadget.c
>@@ -4549,8 +4549,7 @@ static int dwc2_hsotg_udc_start(struct usb_gadget
>*gadget,
> 	hsotg->gadget.dev.of_node =3D hsotg->dev->of_node;
> 	hsotg->gadget.speed =3D USB_SPEED_UNKNOWN;
>
>-	if (hsotg->dr_mode =3D=3D USB_DR_MODE_PERIPHERAL ||
>-	    (hsotg->dr_mode =3D=3D USB_DR_MODE_OTG && dwc2_is_device_mode(hsotg)=
))
>{
>+	if (hsotg->dr_mode =3D=3D USB_DR_MODE_PERIPHERAL) {
> 		ret =3D dwc2_lowlevel_hw_enable(hsotg);
> 		if (ret)
> 			goto err;
>@@ -4612,8 +4611,7 @@ static int dwc2_hsotg_udc_stop(struct usb_gadget
>*gadget)
> 	if (!IS_ERR_OR_NULL(hsotg->uphy))
> 		otg_set_peripheral(hsotg->uphy->otg, NULL);
>
>-	if (hsotg->dr_mode =3D=3D USB_DR_MODE_PERIPHERAL ||
>-	    (hsotg->dr_mode =3D=3D USB_DR_MODE_OTG && dwc2_is_device_mode(hsotg)=
))
>+	if (hsotg->dr_mode =3D=3D USB_DR_MODE_PERIPHERAL)
> 		dwc2_lowlevel_hw_disable(hsotg);
>
> 	return 0;
>diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c ind=
ex
>23ef75996823..262c13b6362a 100644
>--- a/drivers/usb/dwc2/platform.c
>+++ b/drivers/usb/dwc2/platform.c
>@@ -576,8 +576,7 @@ static int dwc2_driver_probe(struct platform_device
>*dev)
> 	dwc2_debugfs_init(hsotg);
>
> 	/* Gadget code manages lowlevel hw on its own */
>-	if (hsotg->dr_mode =3D=3D USB_DR_MODE_PERIPHERAL ||
>-	    (hsotg->dr_mode =3D=3D USB_DR_MODE_OTG && dwc2_is_device_mode(hsotg)=
))
>+	if (hsotg->dr_mode =3D=3D USB_DR_MODE_PERIPHERAL)
> 		dwc2_lowlevel_hw_disable(hsotg);
>
> #if IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) || \
>--
>2.25.1

