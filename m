Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35C37044FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 08:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjEPGLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 02:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjEPGLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:11:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CB92723
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 23:11:38 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34G3PGRM004195;
        Tue, 16 May 2023 06:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Svy4l+hzxpnZMWtHXBn/4YWN6BCTRpwMkrrJw/0D6dc=;
 b=DzWE6jWaYYkEHal2H1iSz0z0TffpYwbpGnHVrW5TvxPfOAKCfgcFnBiEz3WazGvnC21n
 QlpeyMTU16SjuDdKjlC8VwuLcQLhl+P5dzdQlXG4XN1wRLCRzcalppB1ib0lUAPHujXJ
 dDa3WtCAjwLlbKHo03gtgXokPURZ3gWZ8cqvzMmllgvsOsmb7dejj5pX9arLh2GbgSWm
 ljSihiX261szHZiUtHbTlhtVAT8+WEdSt3Ba3D1nPbunY868G864JZGS9OV8/PeJE43p
 ICGGH5fxaBquUCgrbcjgRqs5Ncv/mPJTmaXqA6TV8q6bMXCUa6lRHaknnXCTh+oLbWtQ wg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qkjsctf21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 06:11:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34G6BN3Y003611
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 06:11:23 GMT
Received: from [10.214.66.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 15 May
 2023 23:11:20 -0700
Message-ID: <0a754ebc-dad5-d300-0239-892b74786764@quicinc.com>
Date:   Tue, 16 May 2023 11:41:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V8 0/2] mm: shmem: support POSIX_FADV_[WILL|DONT]NEED for
 shmem files
Content-Language: en-US
To:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <willy@infradead.org>, <markhemm@googlemail.com>,
        <rientjes@google.com>, <surenb@google.com>, <shakeelb@google.com>,
        <fvdl@google.com>, <quic_pkondeti@quicinc.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <cover.1682598808.git.quic_charante@quicinc.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <cover.1682598808.git.quic_charante@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9z1wTRIrGOf1WGGS2FCQQDQwjJum_CCB
X-Proofpoint-ORIG-GUID: 9z1wTRIrGOf1WGGS2FCQQDQwjJum_CCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_01,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160052
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a ping to have your valuable inputs here.

On 4/28/2023 8:32 PM, Charan Teja Kalla wrote:
> This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
> advices to shmem files which can be helpful for the drivers who may want
> to manage the pages of shmem files on their own, like, that are created
> through shmem_file_setup[_with_mnt]().
> 
> This patchset is unit tested with the below:
> (a) Qemu x86_64 with 4 smp cores, 2GB ram, 1Gb swap mounted
>     on zram block device.
> (b) A tmpfs file of size 100MB is created.
> (c) Initially this file is filled with a poison value of 0xAA. 
> (d) POSIX_FADV_[WILL|DONT]NEED is called on this file for a range that
>     gets generated randomn. This is called for 10K iterations.
> (e) Check the poison value at the end of the test. Exit the program if it
>     is changed.
> 
> use the below script:
> val1=$(cat /proc/vmstat | grep pswpout | awk '{print $2}')
> str=$(./a.out <tmpfs file>)
> res=$(echo $str | awk '{print $1}')
> val2=$(cat /proc/vmstat | grep pswpout | awk '{print $2}')
> 
> if [[ $res == "FAIL" ]]; then echo $str;
> else
> 	if [[ $val1 == $val2 ]]; then echo "FAIL. Does the swap setup is done?"; 
>         else echo $res;
>         fi
> fi
> ------------------------------------------------------------------------
> #include <stdio.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/mman.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <sys/stat.h>
> 
> #define NR_ITER   (10000)
> unsigned int fd;
> 
> void run_tests(int fd, loff_t start, loff_t end)
> {
> 
> 	if (posix_fadvise(fd, start, end, POSIX_FADV_DONTNEED)) {
> 		perror("FAIL : fadvise():dont_need_thread\n");
> 		exit(6);
> 	}
> 
> 	if (posix_fadvise(fd, start, end, POSIX_FADV_WILLNEED)) {
> 		perror("FAIL : fadvise():will_need_thread\n");
> 		exit(6);
> 	}
> }
> 
> void get_rand_range(long size, loff_t *start, loff_t *end)
> {
> 	*start = rand() % (size >> 1);
> 	*end = *start + (rand() % size);
> 
> 	if (*end > size)
> 		*start = *end = 0;
> }
> 
> void fill_pattern(int fd, long size)
> {
> 	char *data;
> 
> 	data = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> 	if (data == MAP_FAILED) {
> 		perror("FAIL : mmap()\n");
> 		exit(5);
> 	}
> 	memset(data, 0xAA, size);
> 	munmap(data, size);
> }
> 
> int check_pattern(int fd, long size)
> {
> 	unsigned char *data;
> 	long i;
> 
> 	data = mmap(0, size, PROT_READ, MAP_SHARED, fd, 0);
> 	if (data == MAP_FAILED) {
> 		perror("FAIL : mmap()\n");
> 		exit(4);
> 	}
> 
> 	for (i = 0; i < size; ++i) {
> 		if (data[i] != 0xAA) {
> 			printf("FAIL : Testcase is failed. Seeing %x rather than 0xAA\n", data[i]);
> 			exit(4);
> 		}
> 	}
> 	munmap(data, size);
> }
> 
> int main(int argc, char **argv)
> {
> 	struct stat buf = {0};
> 	loff_t start, end, i;
> 
> 	if (argc < 2) { 
> 		printf("FAIL : usage: a.out <tmpfs filename>\n");
> 		exit(1);
> 	}
> 
> 
> 	if (stat(argv[1], &buf)) {
> 		perror("FAIL : stat()\n");
> 		exit(2);
> 	}
> 
> 	fd = open(argv[1], O_RDWR);
> 	if (fd < 0) {
> 		perror("FAIL : open()\n");
> 		exit(3);
> 	}
> 
> 	fill_pattern(fd, buf.st_size);
> 	for (i = NR_ITER; i > 0; --i) {
> 		get_rand_range(buf.st_size, &start, &end);
> 		run_tests(fd, start, end);
> 	}
> 	check_pattern(fd, buf.st_size);
> 	
> 	close(fd);
> 
> 	printf("PASS \n");
> 
> 	return 0;
> }
> ------------------------------------------------------------------------
> 
> Changes in V8:
>  -- Addressed the comments and fixed the bug caught by Hugh.
>  -- Updated the commit message for POSIX_FADV_WILLNEED asked by Minchan.
> 
> Changes in V7:
>  -- Use folio based interface, shmem_read_folio(), for FADV_WILLNEED.
>  -- Don't swap the SHM_LOCK'ed pages.
>  -- https://lore.kernel.org/all/cover.1676378702.git.quic_charante@quicinc.com/
> 
> Changes in V6:
>  -- Replaced the pages with folio's for shmem changes.
>  -- https://lore.kernel.org/all/cover.1675690847.git.quic_charante@quicinc.com/
> 
> Changes in V5:
>  -- Moved the 'endbyte' calculations to a header function for use by shmem_fadvise().
>  -- Addressed comments from suren.
>  -- No changes in resend. Retested on the latest tip.
>  -- https://lore.kernel.org/all/cover.1648706231.git.quic_charante@quicinc.com/
> 
> Changes in V4:
>   -- Changed the code to use reclaim_pages() to writeout the shmem pages to swap and then reclaim.
>   -- Addressed comments from Mark Hemment and Matthew.
>   -- fadvise() on shmem file may even unmap a page.
>   -- https://patchwork.kernel.org/project/linux-mm/patch/1644572051-24091-1-git-send-email-quic_charante@quicinc.com/
> 
> Changes in V3:
>   -- Considered THP pages while doing FADVISE_[DONT|WILL]NEED, identified by Matthew.
>   -- xarray used properly, as identified by Matthew.
>   -- Excluded mapped pages as it requires unmapping and the man pages of fadvise don't talk about them.
>   -- RESEND: Fixed the compilation issue when CONFIG_TMPFS is not defined.
>   -- https://patchwork.kernel.org/project/linux-mm/patch/1641488717-13865-1-git-send-email-quic_charante@quicinc.com/
> 
> Changes in V2:
>   -- Rearranged the code to not to sleep with rcu_lock while using xas_() functionality.
>   -- Addressed the comments from Suren.
>   -- https://patchwork.kernel.org/project/linux-mm/patch/1638442253-1591-1-git-send-email-quic_charante@quicinc.com/
> 
> changes in V1:
>   -- Created the interface for fadvise(2) to work on shmem files.
>   -- https://patchwork.kernel.org/project/linux-mm/patch/1633701982-22302-1-git-send-email-charante@codeaurora.org/
> 
> 
> Charan Teja Kalla (2):
>   mm: fadvise: move 'endbyte' calculations to helper function
>   mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for shmem
> 
>  mm/fadvise.c  |  11 +----
>  mm/internal.h |  21 ++++++++++
>  mm/shmem.c    | 127 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 149 insertions(+), 10 deletions(-)
> 
