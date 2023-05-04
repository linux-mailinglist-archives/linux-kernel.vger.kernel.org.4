Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB8E6F3B7E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 02:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjEBAwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 20:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEBAw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 20:52:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E03530EE
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 17:52:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-559d1e8dc42so54270647b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 17:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682988745; x=1685580745;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PMr9CSFbKkempgdzzQdL7Zwkt6UumLJeT//GgveDKNc=;
        b=wF/S5NQERpRui8VV7CmlInDtl7fNY4zZ4NWELSVB64eZ+BL3IUzATu4W9rpD+KMOKo
         Q7LXbK24Ismjhasn2z+IVHaR+2KoENDn8Gva3vlq1ubILJi1yZu+7L+tWrXySiBEPRli
         TgelUmL8vI0SXx1AFaQ1UDzvcgHvUTFLcJlopgg0trpoWlcNuzQ7z4GVHNrwPLPUBov7
         xM6vQn+1CItfnsv3iuz9ufdtnR9jlk1xNzhxRa/S2JnPkoieoNlMGjRk1FTBpqc7aEQ+
         Tjzi/+T3HqlnplQk2XG7rZ7shFmhhhjJAwdUt/5+53H0DlE66LuPAW6Ysp8KZhaxfPE3
         sDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682988745; x=1685580745;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMr9CSFbKkempgdzzQdL7Zwkt6UumLJeT//GgveDKNc=;
        b=GL+JJp3p35osi2j8vhteU81zSNnAX9wLL23P2B8o4D2mkhFM1O89UMwvic4ICvG20q
         lj1ZUE2CZ9UIHTGCzwXuRnAXY1c71B6YdR7A+sABF8QoXer78Adioawr73dOOyWxPmmI
         sStFHaQ/cpcamVc95jLLbWhaeSTiZ0syOYLFlAESxqghkiKlZAyFHtLc9uLVA0ppp/3b
         wOCD93jRJbwvZa8mewt/AYsOmEVr8zTYwswpT41A0HiC/AcXn+VYYFH09IYYUnL1PCQf
         q0h7KEMAsx5ab25TdejJzA4jk+AlDndfRqPA1mcMulHVtZOKwZI5y7BRB/l7KHSdvRo/
         4A+A==
X-Gm-Message-State: AC+VfDw5Mh2/de2QQLCGKXlGQT8svYvSZWz0Op4xxGT//U3SWW2cd9kK
        euangrVVxj6gYqFI0ae8p+pwpZFzcss=
X-Google-Smtp-Source: ACHHUZ7oCobC8owwsaLv8x2B0ByE/cvT1vna7koor91mo0f1BZQzjn+N03CUVl3Zl+vk+UaaiXTYo3b6QIE=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:908a:598a:7b5a:d40b])
 (user=drosen job=sendgmr) by 2002:a81:4007:0:b0:545:1d7f:acbf with SMTP id
 l7-20020a814007000000b005451d7facbfmr9025404ywn.10.1682988745369; Mon, 01 May
 2023 17:52:25 -0700 (PDT)
Date:   Mon,  1 May 2023 17:52:16 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502005218.3627530-1-drosen@google.com>
Subject: [PATCH v2 1/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
From:   Daniel Rosenberg <drosen@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bpf_dynptr_slice(_rw) uses a user provided buffer if it can not provide
a pointer to a block of contiguous memory. This buffer is unused in the
case of local dynptrs, and may be unused in other cases as well. There
is no need to require the buffer, as the kfunc can just return NULL if
it was needed and not provided.

This adds another kfunc annotation, __opt, which combines with __sz and
__szk to allow the buffer associated with the size to be NULL. If the
buffer is NULL, the verifier does not check that the buffer is of
sufficient size.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 Documentation/bpf/kfuncs.rst | 23 ++++++++++++++++++++++-
 include/linux/skbuff.h       |  2 +-
 kernel/bpf/helpers.c         | 30 ++++++++++++++++++------------
 kernel/bpf/verifier.c        | 17 +++++++++++++----
 4 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index ea2516374d92..7a3d9de5f315 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -100,7 +100,7 @@ Hence, whenever a constant scalar argument is accepted by a kfunc which is not a
 size parameter, and the value of the constant matters for program safety, __k
 suffix should be used.
 
-2.2.2 __uninit Annotation
+2.2.3 __uninit Annotation
 -------------------------
 
 This annotation is used to indicate that the argument will be treated as
@@ -117,6 +117,27 @@ Here, the dynptr will be treated as an uninitialized dynptr. Without this
 annotation, the verifier will reject the program if the dynptr passed in is
 not initialized.
 
+2.2.4 __opt Annotation
+-------------------------
+
+This annotation is used to indicate that the buffer associated with an __sz or __szk
+argument may be null. If the function is passed a nullptr in place of the buffer,
+the verifier will not check that length is appropriate for the buffer. The kfunc is
+responsible for checking if this buffer is null before using it.
+
+An example is given below::
+
+        __bpf_kfunc void *bpf_dynptr_slice(..., void *buffer__opt, u32 buffer__szk)
+        {
+        ...
+        }
+
+Here, the buffer may be null. If buffer is not null, it at least of size buffer_szk.
+Either way, the returned buffer is either NULL, or of size buffer_szk. Without this
+annotation, the verifier will reject the program if a null pointer is passed in with
+a nonzero size.
+
+
 .. _BPF_kfunc_nodef:
 
 2.3 Using an existing kernel function
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 738776ab8838..8ddb4af1a501 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4033,7 +4033,7 @@ __skb_header_pointer(const struct sk_buff *skb, int offset, int len,
 	if (likely(hlen - offset >= len))
 		return (void *)data + offset;
 
-	if (!skb || unlikely(skb_copy_bits(skb, offset, buffer, len) < 0))
+	if (!skb || !buffer || unlikely(skb_copy_bits(skb, offset, buffer, len) < 0))
 		return NULL;
 
 	return buffer;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8d368fa353f9..26efb6fbeab2 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2167,13 +2167,15 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
  * bpf_dynptr_slice() - Obtain a read-only pointer to the dynptr data.
  * @ptr: The dynptr whose data slice to retrieve
  * @offset: Offset into the dynptr
- * @buffer: User-provided buffer to copy contents into
- * @buffer__szk: Size (in bytes) of the buffer. This is the length of the
- *		 requested slice. This must be a constant.
+ * @buffer__opt: User-provided buffer to copy contents into.  May be NULL
+ * @buffer__szk: Size (in bytes) of the buffer if present. This is the
+ *               length of the requested slice. This must be a constant.
  *
  * For non-skb and non-xdp type dynptrs, there is no difference between
  * bpf_dynptr_slice and bpf_dynptr_data.
  *
+ *  If buffer__opt is NULL, the call will fail if buffer_opt was needed.
+ *
  * If the intention is to write to the data slice, please use
  * bpf_dynptr_slice_rdwr.
  *
@@ -2190,7 +2192,7 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
  * direct pointer)
  */
 __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
-				   void *buffer, u32 buffer__szk)
+				   void *buffer__opt, u32 buffer__szk)
 {
 	enum bpf_dynptr_type type;
 	u32 len = buffer__szk;
@@ -2210,15 +2212,17 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
 	case BPF_DYNPTR_TYPE_RINGBUF:
 		return ptr->data + ptr->offset + offset;
 	case BPF_DYNPTR_TYPE_SKB:
-		return skb_header_pointer(ptr->data, ptr->offset + offset, len, buffer);
+		return skb_header_pointer(ptr->data, ptr->offset + offset, len, buffer__opt);
 	case BPF_DYNPTR_TYPE_XDP:
 	{
 		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);
 		if (xdp_ptr)
 			return xdp_ptr;
 
-		bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer, len, false);
-		return buffer;
+		if (!buffer__opt)
+			return NULL;
+		bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer__opt, len, false);
+		return buffer__opt;
 	}
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
@@ -2230,13 +2234,15 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
  * bpf_dynptr_slice_rdwr() - Obtain a writable pointer to the dynptr data.
  * @ptr: The dynptr whose data slice to retrieve
  * @offset: Offset into the dynptr
- * @buffer: User-provided buffer to copy contents into
- * @buffer__szk: Size (in bytes) of the buffer. This is the length of the
- *		 requested slice. This must be a constant.
+ * @buffer__opt: User-provided buffer to copy contents into. May be NULL
+ * @buffer__szk: Size (in bytes) of the buffer if present. This is the
+ *               length of the requested slice. This must be a constant.
  *
  * For non-skb and non-xdp type dynptrs, there is no difference between
  * bpf_dynptr_slice and bpf_dynptr_data.
  *
+ * If buffer__opt is NULL, the call will fail if buffer_opt was needed.
+ *
  * The returned pointer is writable and may point to either directly the dynptr
  * data at the requested offset or to the buffer if unable to obtain a direct
  * data pointer to (example: the requested slice is to the paged area of an skb
@@ -2267,7 +2273,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
  * direct pointer)
  */
 __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 offset,
-					void *buffer, u32 buffer__szk)
+					void *buffer__opt, u32 buffer__szk)
 {
 	if (!ptr->data || bpf_dynptr_is_rdonly(ptr))
 		return NULL;
@@ -2294,7 +2300,7 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 o
 	 * will be copied out into the buffer and the user will need to call
 	 * bpf_dynptr_write() to commit changes.
 	 */
-	return bpf_dynptr_slice(ptr, offset, buffer, buffer__szk);
+	return bpf_dynptr_slice(ptr, offset, buffer__opt, buffer__szk);
 }
 
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fbcf5a4e2fcd..708ae7bca1fe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9398,6 +9398,11 @@ static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
 	return __kfunc_param_match_suffix(btf, arg, "__szk");
 }
 
+static bool is_kfunc_arg_optional(const struct btf *btf, const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__opt");
+}
+
 static bool is_kfunc_arg_constant(const struct btf *btf, const struct btf_param *arg)
 {
 	return __kfunc_param_match_suffix(btf, arg, "__k");
@@ -10464,13 +10469,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_MEM_SIZE:
 		{
+			struct bpf_reg_state *buff_reg = &regs[regno];
+			const struct btf_param *buff_arg = &args[i];
 			struct bpf_reg_state *size_reg = &regs[regno + 1];
 			const struct btf_param *size_arg = &args[i + 1];
 
-			ret = check_kfunc_mem_size_reg(env, size_reg, regno + 1);
-			if (ret < 0) {
-				verbose(env, "arg#%d arg#%d memory, len pair leads to invalid memory access\n", i, i + 1);
-				return ret;
+			if (!register_is_null(buff_reg) || !is_kfunc_arg_optional(meta->btf, buff_arg)) {
+				ret = check_kfunc_mem_size_reg(env, size_reg, regno + 1);
+				if (ret < 0) {
+					verbose(env, "arg#%d arg#%d memory, len pair leads to invalid memory access\n", i, i + 1);
+					return ret;
+				}
 			}
 
 			if (is_kfunc_arg_const_mem_size(meta->btf, size_arg, size_reg)) {

base-commit: 6e98b09da931a00bf4e0477d0fa52748bf28fcce
-- 
2.40.1.495.gc816e09b53d-goog

