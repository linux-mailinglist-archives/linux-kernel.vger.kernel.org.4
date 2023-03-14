Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA266B88DF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 04:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjCNDMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 23:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCNDMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 23:12:18 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28D782A9B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 20:12:16 -0700 (PDT)
Received: from 30.221.131.40(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VdqKWDt_1678763533)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 11:12:13 +0800
Message-ID: <a9aae568-3046-306c-bd71-92c1fc8eeddc@linux.alibaba.com>
Date:   Tue, 14 Mar 2023 11:12:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Content-Language: en-US
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: [BUG REPORT] arch/x86/include/asm/uaccess_64.h:119: Error: junk at
 end of line
To:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My container failed to compile the latest v6.3, and bisecting shows that
commit 5d1dd961e74334a2178264193ea813d44ce5e725 ("x86/alternatives: Add
alt_instr.flags") introduces the regression.

```
./arch/x86/include/asm/uaccess_64.h:124: Error: found 'L', expected: ')'
./arch/x86/include/asm/uaccess_64.h:124: Error: found 'L', expected: ')'
./arch/x86/include/asm/uaccess_64.h:124: Error: found 'L', expected: ')'
./arch/x86/include/asm/uaccess_64.h:124: Error: found 'L', expected: ')'
./arch/x86/include/asm/uaccess_64.h:124: Error: found 'L', expected: ')'
./arch/x86/include/asm/uaccess_64.h:124: Error: found 'L', expected: ')'
./arch/x86/include/asm/uaccess_64.h:124: Error: junk at end of line,
first unrecognized character is `L'
```

The gcc inside container is:

	gcc (GCC) 6.5.1 20181026 (Alibaba 6.5.1-1)


While the gcc on the host can compile it successfully:
	
	gcc (GCC) 9.2.1 20200522 (Alibaba 9.2.1-3 2.17)


-- 
Thanks,
Jingbo
