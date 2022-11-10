Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC3D624D88
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiKJWMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiKJWMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:12:39 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA30450B6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Subject:From:Cc:To:MIME-Version:Date:Message-ID:Content-Type:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ehOVmf2BGJ/4XYcU1MULgCYiKF3gEtoi5LbwIzjFNf4=; b=i4gj0D5faVv1xOXerbvbwjpkVj
        r+9WoDtYzORegVRsH57rIBoGtc+Vc03xnNWODx/W3d6llbjxDiR2FkSWRrLswGuLtg6xVOBBOJw/k
        12XOiEi5Q1vv7IoXULOpx/CC5GNR2O7WEhPf55vJcpAzX/nmIryxGfsc4ZYeH4TKLtzblHv7HK3VC
        tlbQPkCIuQCU+A2jXmAcFUjf4ejooOKCxUb3eTLXlltKYMMV7YlEue8Dy1DeMb8LnjQevP4eLLflp
        QVt1EJbzmwWeDQAaFNusmsZF42GfviQfoMNPA9ab+l9ZAEzTULL6jPsWXWTxliix7IBtLb40z5XIs
        va56zLkg==;
Received: from [177.102.6.147] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1otF3R-00FllT-RH; Thu, 10 Nov 2022 22:25:46 +0100
Content-Type: multipart/mixed; boundary="------------4sU3PuLspeCdCDuX0VcIUpqh"
Message-ID: <1ef5fe19-a82f-835e-fda5-455e9c2b94b4@igalia.com>
Date:   Thu, 10 Nov 2022 18:25:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Content-Language: en-US
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: RCU stall on 6.1-rc4 (and some previous releases) related to ftrace
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4sU3PuLspeCdCDuX0VcIUpqh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi folks, I've noticed some RCU stalls when enabling ftrace filtering in
6.1-rc4 (also 6.1-rc3 and I guess I've seen this before, but only in
6.0+). Here is the full dmesg: https://termbin.com/4xo6 , see below for
a small snippet of the stall [0].

I've briefly talked to Steve on IRC, and he mentioned that my kernel
seemed to have PREEMPT_VOLUNTARY=y (and indeed, this is the case - see
the full config here: https://termbin.com/t48d), saying that maybe
adding a cond_resched() in the loop would help.

So, I've cooked a small hack (see the patch attached) and it seems to
work. Steve: lemme know if you want to send it (since it's your idea and
maybe my hack is not covering all cases), or if you prefer, I can work a
commit message and send myself.

Any other advice / tests required, please lemme me know and I'll be glad
in contributing.

Cheers,


Guilherme


[0]
rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-....
} 6 jiffies s: 1289 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 4 to CPUs 1:
NMI backtrace for cpu 1
[...]
RIP: 0010:find_kallsyms_symbol+0x85/0x1a0
[...]
Call Trace:
 <TASK>
 ? get_refcyc_per_delivery.constprop.0+0x200/0x200 [amdgpu]
 module_address_lookup+0x63/0xc0
 ? get_refcyc_per_delivery.constprop.0+0x200/0x200 [amdgpu]
 kallsyms_lookup_buildid+0xb6/0x130
 ftrace_match_record+0x43/0xf0
 ? match_records+0x210/0x3b0
 ? __kmem_cache_alloc_node+0x165/0x260
 match_records+0x13a/0x3b0
 ftrace_process_regex.isra.0+0x101/0x120
 ftrace_filter_write+0x57/0x90
[...]
rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-....
} 25 jiffies s: 1289 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 4 to CPUs 1:
[...]
RIP: 0010:find_kallsyms_symbol+0x8f/0x1a0
[...]
Call Trace:
 <TASK>
 ? dcn21_dmcu_create+0xd0/0xd0 [amdgpu]
 module_address_lookup+0x63/0xc0
 ? dcn21_dmcu_create+0xd0/0xd0 [amdgpu]
 kallsyms_lookup_buildid+0xb6/0x130
 ftrace_match_record+0x43/0xf0
 ? match_records+0x210/0x3b0
 ? __kmem_cache_alloc_node+0x165/0x260
 match_records+0x13a/0x3b0
 ftrace_process_regex.isra.0+0x101/0x120
 ftrace_filter_write+0x57/0x90
[...]
--------------4sU3PuLspeCdCDuX0VcIUpqh
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ftrace-hack-Add-cond_resched-to-prevent-RCU-stall.patch"
Content-Disposition: attachment;
 filename*0="0001-ftrace-hack-Add-cond_resched-to-prevent-RCU-stall.patch"
Content-Transfer-Encoding: base64

RnJvbSA0NWZkYTM2OWE0OWQwZTU5Njg5ZTRhNmI5YmFiYzEyNTk4MjY1ODI1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiAiR3VpbGhlcm1lIEcuIFBpY2NvbGkiIDxncGljY29s
aUBpZ2FsaWEuY29tPgpEYXRlOiBUaHUsIDEwIE5vdiAyMDIyIDE2OjQyOjE3IC0wMzAwClN1
YmplY3Q6IFtQQVRDSF0gZnRyYWNlL2hhY2s6IEFkZCBjb25kX3Jlc2NoZWQoKSB0byBwcmV2
ZW50IFJDVSBzdGFsbAoKU3VnZ2VzdGlvbiBmcm9tIFN0ZXZlIG9uIElSQwotLS0KIGtlcm5l
bC90cmFjZS9mdHJhY2UuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
CgpkaWZmIC0tZ2l0IGEva2VybmVsL3RyYWNlL2Z0cmFjZS5jIGIva2VybmVsL3RyYWNlL2Z0
cmFjZS5jCmluZGV4IDdkYzAyMzY0MWJmMS4uOGMyYzA0YjJlYjUyIDEwMDY0NAotLS0gYS9r
ZXJuZWwvdHJhY2UvZnRyYWNlLmMKKysrIGIva2VybmVsL3RyYWNlL2Z0cmFjZS5jCkBAIC00
MTg0LDYgKzQxODQsNyBAQCBtYXRjaF9yZWNvcmRzKHN0cnVjdCBmdHJhY2VfaGFzaCAqaGFz
aCwgY2hhciAqZnVuYywgaW50IGxlbiwgY2hhciAqbW9kKQogCQlpZiAocmVjLT5mbGFncyAm
IEZUUkFDRV9GTF9ESVNBQkxFRCkKIAkJCWNvbnRpbnVlOwogCisJCWNvbmRfcmVzY2hlZCgp
OwogCQlpZiAoZnRyYWNlX21hdGNoX3JlY29yZChyZWMsICZmdW5jX2csIG1vZF9tYXRjaCwg
ZXhjbHVkZV9tb2QpKSB7CiAJCQlyZXQgPSBlbnRlcl9yZWNvcmQoaGFzaCwgcmVjLCBjbGVh
cl9maWx0ZXIpOwogCQkJaWYgKHJldCA8IDApIHsKLS0gCjIuMzguMAoK

--------------4sU3PuLspeCdCDuX0VcIUpqh--
