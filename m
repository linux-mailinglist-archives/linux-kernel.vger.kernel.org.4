Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB736B87A6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjCNBhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCNBhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:37:22 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982D08F518
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:37:17 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230314013714epoutp04ca2f81020db8bc57f173215d175a6950~MJVsXHqfj1244712447epoutp04W
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:37:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230314013714epoutp04ca2f81020db8bc57f173215d175a6950~MJVsXHqfj1244712447epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678757834;
        bh=A7V77BacVIZ1CfXwebVlpytr8W8698A2iyAIUzoKyRo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=SEGb1eytl8aJWQh9LFUXeiN1tVe/d8mgQzbjmvmz98+sWkpdrGE7oUCzskoVG/lWj
         XOqYnbPXxyL0W3w4Tef+wpluVBjPiCVNxU5ooYjzIPuVgFXLBeSMZh2uHlsKU0TKHE
         iTBUeD8h4zP68xfhvOABMI7JT1q7qGZSXfo9YyIQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230314013713epcas1p3c92b9abd3e52523e40122bd7acd04b70~MJVsBnw-A0622406224epcas1p39;
        Tue, 14 Mar 2023 01:37:13 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.232]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PbGNS6Mf5z4x9QB; Tue, 14 Mar
        2023 01:37:12 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.3D.54823.8CFCF046; Tue, 14 Mar 2023 10:37:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230314013712epcas1p174a260fa55e9661dac7ea816a8ea96f4~MJVqfP9zp1180811808epcas1p1n;
        Tue, 14 Mar 2023 01:37:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230314013712epsmtrp1f660cc715801a7ae703847511175290f~MJVqeoFTG1535115351epsmtrp1G;
        Tue, 14 Mar 2023 01:37:12 +0000 (GMT)
X-AuditID: b6c32a39-d01fc7000000d627-3c-640fcfc88b2e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.09.31821.8CFCF046; Tue, 14 Mar 2023 10:37:12 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.111.54]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230314013712epsmtip27df62576e8fea57d283b838741257098~MJVqSDZHl0266902669epsmtip2f;
        Tue, 14 Mar 2023 01:37:12 +0000 (GMT)
From:   Sung-hun Kim <sfoon.kim@samsung.com>
To:     rostedt@goodmis.org, mhirmat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     sungguk.na@samsung.com, sw0312.kim@samsung.com,
        Sung-hun Kim <sfoon.kim@samsung.com>
Subject: [PATCH] tracing: Make splice_read available again
Date:   Tue, 14 Mar 2023 10:37:07 +0900
Message-Id: <20230314013707.28814-1-sfoon.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7bCmvu6J8/wpBn+uyltc3jWHzeLI+rMs
        FjdWXmC32NfxgMmicdpydosd8w4yWsyY/JLNgd2jZd8tdo9NqzrZPPq2rGL0+LxJLoAlKtsm
        IzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gCJYWyxJxS
        oFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BaYFecWJucWleul5eaomVoYGBkSlQYUJ2xrL9
        dQUzOCqu7pNqYHzJ1sXIySEhYCKxY9Zv9i5GLg4hgR2MEgs+nmSEcD4xSjTeWs4EUiUk8JlR
        4vkWXpiO37c/QnXsYpSYcnYJG4QDVNT37SDYXDYBLYlt+y8xgtgiAvkSbUsng8WZBaIkLuxr
        YQaxhQWsJPYv+sAKYrMIqEqsXjiXHcTmBYrP7VoCdZ+8xOoNB5hBFkgILGKX2PxuIVTCRaJr
        /WpmCFtY4tXxLewQtpTEy/42IJsDyK6WmPqcG6K3hVHi38v9rBA1xhL7l05mAqlhFtCUWL9L
        HyKsKLHz91xGiDv5JN597WGFGMMr0dEmBFGiLPH4YDMLhC0p8XXfdSYI20Pi5fL5jJDAipWY
        +PoZywRG2VkICxYwMq5iFEstKM5NTy02LDCFR1Fyfu4mRnCS0rLcwTj97Qe9Q4xMHIyHGCU4
        mJVEeLfw86QI8aYkVlalFuXHF5XmpBYfYjQFhtdEZinR5HxgmswriTc0sTQwMTMyNrEwNDNU
        EucVtz2ZLCSQnliSmp2aWpBaBNPHxMEp1cB0+H5nReKqS32JJ+cxu29TP6yeffRZ8+W8ApHb
        QrUXhN0WJTEUb/y377N/gcaJGY+/sy4/sGqP0Z+9qhHsK+MY+Uv2rq9Ydml6znrjtDXeFyRM
        Fte2rpxxioV7H9OLiLRHF+cL856/sHmd6I93b9eFd8hqNMYqp69caNn9Omfr5SvW5zYZSFlO
        /p3F83jKuR8cUvJqMZ4Zfoun6lsz/WoQbrLa6yuomFY+s08tg/uAi3PNg8S3bX5erVe0bhTm
        d9V5XvVaN+N+BO+uS6/26mRKHL7js3CDxccZCsVsgh3v9st0XbblO/4jOuRlSL+Kb9DnOdq/
        VVyd1up3S55LPSAwoaZjx9VrF57nTXulvmanEktxRqKhFnNRcSIATvXCRtsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGJMWRmVeSWpSXmKPExsWy7bCSvO6J8/wpBo/n81hc3jWHzeLI+rMs
        FjdWXmC32NfxgMmicdpydosd8w4yWsyY/JLNgd2jZd8tdo9NqzrZPPq2rGL0+LxJLoAlissm
        JTUnsyy1SN8ugStj2f66ghkcFVf3STUwvmTrYuTkkBAwkfh9+yN7FyMXh5DADkaJszfPQyUk
        JeasW8DYxcgBZAtLHD5cDFHzkVHiZ9cidpAaNgEtiW37L4HViAgUS+zpUAUJMwvESLSvn80E
        YgsLWEnsX/SBFcRmEVCVWL1wLlgrL1B8btcSqFXyEqs3HGCewMizgJFhFaNkakFxbnpusWGB
        UV5quV5xYm5xaV66XnJ+7iZGcNBoae1g3LPqg94hRiYOxkOMEhzMSiK8W/h5UoR4UxIrq1KL
        8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg8i9cIz05/nLvgpaUglXz
        eGR1H4anei56X5wbOK0/wXBS1o0tSttDfp69d3BewMbiP3lanHUJNR9kraf+3O78wfP28vON
        S6zPLD0zs15vRdibUo7LGQ9/nzKY5LPX5A3rpxUrIk8KChzbfvjW1J/VEZasPZreP+74T1M9
        cbJisdN9C6m+FWXWEi5M3Mte+rx9lXOHdcXJphLhnOgbz8K3X5p6wu2hjSDL8ZPi3CUaATJS
        Vaf+8p26qLhx66mGS+1ZHv8ylDSKv2VLXZTYPjVsSp/YbKHqkBuavt+P9ydzL817ZRuSZMRh
        e/Z1520WRcvq2WYR1bwRLz8+PnI26f3e5NaIV+Xf5dg4d/VGGh70VGIpzkg01GIuKk4EAGs9
        06CJAgAA
X-CMS-MailID: 20230314013712epcas1p174a260fa55e9661dac7ea816a8ea96f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230314013712epcas1p174a260fa55e9661dac7ea816a8ea96f4
References: <CGME20230314013712epcas1p174a260fa55e9661dac7ea816a8ea96f4@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 36e2c7421f02 ("fs: don't allow splice read/write
without explicit ops") is applied to the kernel, splice() and
sendfile() calls on the trace file (/sys/kernel/debug/tracing
/trace) return EINVAL.

This patch restores these system calls by initializing splice_read
in file_operations of the trace file. This patch only enables such
functionalities for the read case.

Signed-off-by: Sung-hun Kim <sfoon.kim@samsung.com>
---
 kernel/trace/trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 45551c7b4c36..937e9676dfd4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5167,6 +5167,8 @@ loff_t tracing_lseek(struct file *file, loff_t offset, int whence)
 static const struct file_operations tracing_fops = {
 	.open		= tracing_open,
 	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read	= generic_file_splice_read,
 	.write		= tracing_write_stub,
 	.llseek		= tracing_lseek,
 	.release	= tracing_release,
-- 
2.17.1

