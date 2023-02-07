Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611F768DFEF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjBGSXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjBGSWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:22:50 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E983EC65
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:22:16 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so1439724wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDx7T0DoesuJu11EAm+wkoCIPGz0NXgtPzD3mzQ3Dqc=;
        b=CuBQ3Aqda9FbAfTlLgKl4FN3bkS9dPBa3PV2mNHBxuKoDW0F4hDebow89K4kxbvLIg
         Y4rT5OoNLrjD8eAKzerZvqnpd5F8tYqObG5Axl8gl/8QzcGXLOQX3eyHytYrZzFhjlgp
         FcY+sEfg8wVm1RjIU2GNK3OLjYjLTz6VAH2aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDx7T0DoesuJu11EAm+wkoCIPGz0NXgtPzD3mzQ3Dqc=;
        b=7YwaogA8w0gg+ycama4ctQt/7pRtN9fwkexx8JFsZubsc5pfNXhG/pZ7G6BqUecbjo
         3kkzUvGAMmYSOyeZAD7cowHefpeEeJLtaA5FT3bq5Oob9rGYEc6k5of2jp79zJ7VVwP3
         SJkr1ubnSqL5GI1JOm/d8BAYgJ9D7h0rh6xTf/bDY4NtkhRTfXiIb/d5z65brE+S4aKT
         jRQeMu7AUDrUrqAZ5eEYJ7/yQeO7u6jtvC+0L7ytU/+R5jSIXsc5fDigifpuGEsKoyXa
         T9nNlT3CzThp8s88oRMXXCr3ytmPR5Odet/lkFfyWSkrzseg2G6ekvGgbKjj2N4xcjPM
         QOaQ==
X-Gm-Message-State: AO0yUKXFjhCEwjSu70JH9TxvDLWOEv7JNtXDMk0susyifya5gq90HTAJ
        8O/OMiVtlEg3Sf7vq/9nyggnpA==
X-Google-Smtp-Source: AK7set8rB2J6Zfgk15y1JnhZkeFzRb4WMub61Cl1vwNCdEfMGhHZ64DRjOwaraLbDcQAli97SX/xuQ==
X-Received: by 2002:a05:600c:4b30:b0:3dc:4871:7b66 with SMTP id i48-20020a05600c4b3000b003dc48717b66mr2380913wmp.29.1675794135936;
        Tue, 07 Feb 2023 10:22:15 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:5307:c0c0:ff97:80de])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c4f8600b003daf672a616sm15578369wmq.22.2023.02.07.10.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:22:15 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v2 10/10] selftests/bpf: Update the tests deny list on aarch64
Date:   Tue,  7 Feb 2023 19:21:35 +0100
Message-Id: <20230207182135.2671106-11-revest@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230207182135.2671106-1-revest@chromium.org>
References: <20230207182135.2671106-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that ftrace supports direct call on arm64, BPF tracing programs work
on that architecture. This fixes the vast majority of BPF selftests
except for:

- multi_kprobe programs which require fprobe, not available on arm64 yet
- tracing_struct which requires trampoline support to access struct args

This patch updates the list of BPF selftests which are known to fail so
the BPF CI can validate the tests which pass now.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64 | 82 ++------------------
 1 file changed, 5 insertions(+), 77 deletions(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 99cc33c51eaa..6b95cb544094 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -1,33 +1,5 @@
-bloom_filter_map                                 # libbpf: prog 'check_bloom': failed to attach: ERROR: strerror_r(-524)=22
-bpf_cookie/lsm
-bpf_cookie/multi_kprobe_attach_api
-bpf_cookie/multi_kprobe_link_api
-bpf_cookie/trampoline
-bpf_loop/check_callback_fn_stop                  # link unexpected error: -524
-bpf_loop/check_invalid_flags
-bpf_loop/check_nested_calls
-bpf_loop/check_non_constant_callback
-bpf_loop/check_nr_loops
-bpf_loop/check_null_callback_ctx
-bpf_loop/check_stack
-bpf_mod_race                                     # bpf_mod_kfunc_race__attach unexpected error: -524 (errno 524)
-bpf_tcp_ca/dctcp_fallback
-btf_dump/btf_dump: var_data                      # find type id unexpected find type id: actual -2 < expected 0
-cgroup_hierarchical_stats                        # attach unexpected error: -524 (errno 524)
-d_path/basic                                     # setup attach failed: -524
-deny_namespace                                   # attach unexpected error: -524 (errno 524)
-fentry_fexit                                     # fentry_attach unexpected error: -1 (errno 524)
-fentry_test                                      # fentry_attach unexpected error: -1 (errno 524)
-fexit_sleep                                      # fexit_attach fexit attach failed: -1
-fexit_stress                                     # fexit attach unexpected fexit attach: actual -524 < expected 0
-fexit_test                                       # fexit_attach unexpected error: -1 (errno 524)
-get_func_args_test                               # get_func_args_test__attach unexpected error: -524 (errno 524) (trampoline)
-get_func_ip_test                                 # get_func_ip_test__attach unexpected error: -524 (errno 524) (trampoline)
-htab_update/reenter_update
-kfree_skb                                        # attach fentry unexpected error: -524 (trampoline)
-kfunc_call/subprog                               # extern (var ksym) 'bpf_prog_active': not found in kernel BTF
-kfunc_call/subprog_lskel                         # skel unexpected error: -2
-kfunc_dynptr_param/dynptr_data_null              # libbpf: prog 'dynptr_data_null': failed to attach: ERROR: strerror_r(-524)=22
+bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
+bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
 kprobe_multi_bench_attach                        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 kprobe_multi_test/attach_api_addrs               # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 kprobe_multi_test/attach_api_pattern             # bpf_program__attach_kprobe_multi_opts unexpected error: -95
@@ -35,50 +7,6 @@ kprobe_multi_test/attach_api_syms                # bpf_program__attach_kprobe_mu
 kprobe_multi_test/bench_attach                   # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 kprobe_multi_test/link_api_addrs                 # link_fd unexpected link_fd: actual -95 < expected 0
 kprobe_multi_test/link_api_syms                  # link_fd unexpected link_fd: actual -95 < expected 0
-kprobe_multi_test/skel_api                       # kprobe_multi__attach unexpected error: -524 (errno 524)
-ksyms_module/libbpf                              # 'bpf_testmod_ksym_percpu': not found in kernel BTF
-ksyms_module/lskel                               # test_ksyms_module_lskel__open_and_load unexpected error: -2
-libbpf_get_fd_by_id_opts                         # test_libbpf_get_fd_by_id_opts__attach unexpected error: -524 (errno 524)
-linked_list
-lookup_key                                       # test_lookup_key__attach unexpected error: -524 (errno 524)
-lru_bug                                          # lru_bug__attach unexpected error: -524 (errno 524)
-modify_return                                    # modify_return__attach failed unexpected error: -524 (errno 524)
-module_attach                                    # skel_attach skeleton attach failed: -524
-mptcp/base                                       # run_test mptcp unexpected error: -524 (errno 524)
-netcnt                                           # packets unexpected packets: actual 10001 != expected 10000
-rcu_read_lock                                    # failed to attach: ERROR: strerror_r(-524)=22
-recursion                                        # skel_attach unexpected error: -524 (errno 524)
-ringbuf                                          # skel_attach skeleton attachment failed: -1
-setget_sockopt                                   # attach_cgroup unexpected error: -524
-sk_storage_tracing                               # test_sk_storage_tracing__attach unexpected error: -524 (errno 524)
-skc_to_unix_sock                                 # could not attach BPF object unexpected error: -524 (errno 524)
-socket_cookie                                    # prog_attach unexpected error: -524
-stacktrace_build_id                              # compare_stack_ips stackmap vs. stack_amap err -1 errno 2
-task_local_storage/exit_creds                    # skel_attach unexpected error: -524 (errno 524)
-task_local_storage/recursion                     # skel_attach unexpected error: -524 (errno 524)
-test_bprm_opts                                   # attach attach failed: -524
-test_ima                                         # attach attach failed: -524
-test_local_storage                               # attach lsm attach failed: -524
-test_lsm                                         # test_lsm_first_attach unexpected error: -524 (errno 524)
-test_overhead                                    # attach_fentry unexpected error: -524
-timer                                            # timer unexpected error: -524 (errno 524)
-timer_crash                                      # timer_crash__attach unexpected error: -524 (errno 524)
-timer_mim                                        # timer_mim unexpected error: -524 (errno 524)
-trace_printk                                     # trace_printk__attach unexpected error: -1 (errno 524)
-trace_vprintk                                    # trace_vprintk__attach unexpected error: -1 (errno 524)
-tracing_struct                                   # tracing_struct__attach unexpected error: -524 (errno 524)
-trampoline_count                                 # attach_prog unexpected error: -524
-unpriv_bpf_disabled                              # skel_attach unexpected error: -524 (errno 524)
-user_ringbuf/test_user_ringbuf_post_misaligned   # misaligned_skel unexpected error: -524 (errno 524)
-user_ringbuf/test_user_ringbuf_post_producer_wrong_offset
-user_ringbuf/test_user_ringbuf_post_larger_than_ringbuf_sz
-user_ringbuf/test_user_ringbuf_basic             # ringbuf_basic_skel unexpected error: -524 (errno 524)
-user_ringbuf/test_user_ringbuf_sample_full_ring_buffer
-user_ringbuf/test_user_ringbuf_post_alignment_autoadjust
-user_ringbuf/test_user_ringbuf_overfill
-user_ringbuf/test_user_ringbuf_discards_properly_ignored
-user_ringbuf/test_user_ringbuf_loop
-user_ringbuf/test_user_ringbuf_msg_protocol
-user_ringbuf/test_user_ringbuf_blocking_reserve
-verify_pkcs7_sig                                 # test_verify_pkcs7_sig__attach unexpected error: -524 (errno 524)
-vmlinux                                          # skel_attach skeleton attach failed: -524
+kprobe_multi_test/skel_api                       # libbpf: failed to load BPF skeleton 'kprobe_multi': -3
+module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
+tracing_struct                                   # tracing_struct__attach unexpected error: -524 (errno 524)
\ No newline at end of file
-- 
2.39.1.519.gcb327c4b5f-goog

