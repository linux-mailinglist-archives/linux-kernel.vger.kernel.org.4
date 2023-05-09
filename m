Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E14A6FCD18
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbjEIR7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjEIR7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:59:12 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0EF4480
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 10:59:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683655151; x=1683662351; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=3UCNsG9zTtlSKFUi3pfdqS/d3QkDhijjCHrzZONc2RU=;
 b=gsBdKyJr/BVWmZSFKUzYAAN83qbvND6yPtUOmxkTfi3bdcR7ZFCPKDHgiucWaV0Ct3YU9WDq6y5tNyOVdQ/a4bx9zLdBKKjFSKAqxROpDUSXS3egH8rGURW46vMi1iJQcVt1W/wvlrbvFx5hYHGJoi6p0RMP4AjUMp7YTFMmOJfLCkQAPRoMDyHADVMtJwsIbJ9UdughrzJKS8MJOM+Uh77HEuXL6SuYAnzmfJGqrkzB4VPH99bHO2Q6pn0YbGtNfdjYHWgp/FG6g11/q8ZTHk4Spto/BzYJVzkqubNvLFC27UNHkKPgLgS5tMF8ey57W5rbHMjRRNJFo+N4RqlnAg==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by cd847f61b1c3 with SMTP id
 645a89eff77227a83016954f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 May 2023 17:59:11 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     James Seo <james@equiv.tech>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] err.h: Add missing kerneldocs for error pointer functions
Date:   Tue,  9 May 2023 10:55:46 -0700
Message-Id: <20230509175543.2065835-3-james@equiv.tech>
In-Reply-To: <20230509175543.2065835-1-james@equiv.tech>
References: <20230509175543.2065835-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kerneldocs for ERR_PTR(), PTR_ERR(), PTR_ERR_OR_ZERO(), IS_ERR(),
and IS_ERR_OR_NULL(). Doing so will help convert hundreds of mentions
of them in existing documentation into automatic cross-references.

Also add kerneldocs for IS_ERR_VALUE(). Doing so adds no automatic
cross-references, but this macro has a slightly different use case
than the functionally similar IS_ERR(), and documenting it may be
helpful to readers who encounter it in existing code.

ERR_CAST() already has kerneldocs and has not been touched.

Signed-off-by: James Seo <james@equiv.tech>
---
 include/linux/err.h | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/linux/err.h b/include/linux/err.h
index a139c64aef2a..c804118ae73d 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -19,23 +19,54 @@
 
 #ifndef __ASSEMBLY__
 
+/**
+ * IS_ERR_VALUE - Detect an error pointer.
+ * @x: The pointer to check.
+ *
+ * Like IS_ERR(), but does not generate a compiler warning if result is unused.
+ */
 #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
 
+/**
+ * ERR_PTR - Create an error pointer.
+ * @error: A negative error code.
+ *
+ * Encodes @error into a pointer value. Users should consider the result
+ * opaque and not assume anything about how the error is encoded.
+ *
+ * Return: A pointer with @error encoded within its value.
+ */
 static inline void * __must_check ERR_PTR(long error)
 {
 	return (void *) error;
 }
 
+/**
+ * PTR_ERR - Extract the error code from an error pointer.
+ * @ptr: An error pointer.
+ * Return: The error code within @ptr.
+ */
 static inline long __must_check PTR_ERR(__force const void *ptr)
 {
 	return (long) ptr;
 }
 
+/**
+ * IS_ERR - Detect an error pointer.
+ * @ptr: The pointer to check.
+ * Return: true if @ptr is an error pointer, false otherwise.
+ */
 static inline bool __must_check IS_ERR(__force const void *ptr)
 {
 	return IS_ERR_VALUE((unsigned long)ptr);
 }
 
+/**
+ * IS_ERR_OR_NULL - Detect an error pointer or a null pointer.
+ * @ptr: The pointer to check.
+ *
+ * Like IS_ERR(), but also returns true for a null pointer.
+ */
 static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
 {
 	return unlikely(!ptr) || IS_ERR_VALUE((unsigned long)ptr);
@@ -54,6 +85,23 @@ static inline void * __must_check ERR_CAST(__force const void *ptr)
 	return (void *) ptr;
 }
 
+/**
+ * PTR_ERR_OR_ZERO - Extract the error code from a pointer if it has one.
+ * @ptr: A potential error pointer.
+ *
+ * Convenience function that can be used inside a function that returns
+ * an error code to propagate errors received as error pointers.
+ * For example, ``return PTR_ERR_OR_ZERO(ptr);`` replaces:
+ *
+ * .. code-block:: c
+ *
+ *	if (IS_ERR(ptr))
+ *		return PTR_ERR(ptr);
+ *	else
+ *		return 0;
+ *
+ * Return: The error code within @ptr if it is an error pointer; 0 otherwise.
+ */
 static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
 {
 	if (IS_ERR(ptr))
-- 
2.34.1

