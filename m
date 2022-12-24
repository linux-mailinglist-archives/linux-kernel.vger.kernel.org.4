Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE4B6557A5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 02:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbiLXBiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 20:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbiLXBhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 20:37:22 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD953137F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 17:32:28 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id q128so5844735vsa.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 17:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N84mEGxx60Oi6ICylGbHLaO/N0bZVYR7+tEjXfEDxio=;
        b=IYDZRDgForV26iJS3Q36bVYpkcfhKPuDImuyLw6v6iGpDXNqUuKHrMVCGIkK28cPXV
         avL6fv5MRiRiRsfPtUcvRXFJoLF/dabb9Y64jAu+ULeogjWsKqY4/LNkrRv1Xp1Rah2z
         wHpFBRgCwksKOKLfJ/1K1/C2K5uCxkGVIZyb25FYR+4DwNlkpV/Co3pdTnct2+yqlrMi
         usiMvOs6x73VrblF7hEkYRaJE+Vtj6iO23Ia2KniPPsvnFE2OKooZ20qqm6eLHsFgmqd
         xG3pPP1b+8zkUIzEOKF2Pec9sbX+9uLZ/vHBHmg5OolrDs//Y3CxC1xfpHMWrm4l8be9
         W6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N84mEGxx60Oi6ICylGbHLaO/N0bZVYR7+tEjXfEDxio=;
        b=qVcHKmUA7Ltx3PiJ7DSmRDE5qfzcqjdVnK/Wqu8x6IeT63yQOvsunXsZgUsTEG2Bvl
         sY2j/ogo5UM2NzzrSoA5Z3RWBYg+Q4oT3xtNX68R1DOu/zjwkODfe570H2Ym+gBh2UX1
         pz/a5XljwEIOhZNjcvvdx7CRqLZudD040GXWMnrg+loaJd4DUr3ifP0Z6HvQ6pMux825
         laRA7ix5iaR6cQrSKl7Y/MbZs7yg38NsT/MK0B8vqt6F8ihabdQArXIqbzKZ6KUK9CSl
         U/hz63d1GUj2Ui5VW/d7HlmP3gTjQWlUSsxqsTu8lYlwSz41pwHSduoUhjyl10hSNcji
         RXAA==
X-Gm-Message-State: AFqh2ko3+Jvw99lrSxW/DqEkoRND3Sxt1bxGhPQlzhj25uqsEGjVnTj+
        RGs9cQBilEe2sHHSrPZFCREa1+yn2P9kUCrM6bgSyNYDhjY=
X-Google-Smtp-Source: AMrXdXueeW3Aq2QsqbXWoCqgnmVngqbdowjxCRkv9w1ITMOqdkigo433I+c3ClW5GqwLMuZX/86UEAMDFrbF3QUebEE=
X-Received: by 2002:a67:c118:0:b0:3c0:8cf4:1540 with SMTP id
 d24-20020a67c118000000b003c08cf41540mr1450457vsj.23.1671845539602; Fri, 23
 Dec 2022 17:32:19 -0800 (PST)
MIME-Version: 1.0
From:   jim.cromie@gmail.com
Date:   Fri, 23 Dec 2022 18:31:53 -0700
Message-ID: <CAJfuBxzzg=w-q5grXhXKU2bkROd0LoXiamj2r0ket5oPHKskKQ@mail.gmail.com>
Subject: use / misuse of EXPORT_SYMBOL ?
To:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>, maennich@google.com
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi folks,

so Im trying to fix a regression in
CONFIG_DRM_USE_DYNAMIC_DEBUG=y
drm.debugs in drivers and helpers arent enabled
cuz theyre not modprobed until after drm,
when its debug=0x1f is applied.
Previously, __drm_debug settings were seen by drm_dbg when called,
but now with dyndbg underneath, that runtime test is replaced
by a static-key, which missed the debug callback and enablement

I want to export a symbol / struct _var
from inside a macro, the _var is placed into its own
linker section, but this appears to make it un-linkable
(at least not the way Im expecting)

WIP patchset at
https://github.com/jimc/linux/tree/hf-5f

Heres the final change, and the ensuing compile errs,
which are more helpful than the previous: silence and misbehavior.

The change isnt correct, but I have a hunch that
the errs reveal something about the underlying problem.

[jimc@frodo f2]$ git diff
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 02a66fd047b2..1d88ebf00bb1 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -111,7 +111,7 @@ struct ddebug_class_map {
                .length = ARRAY_SIZE(_var##_classnames),                \
                .class_names = _var##_classnames,                       \
        };                                                              \
-       EXPORT_SYMBOL(_var)
+       __EXPORT_SYMBOL(_var, "__dyndbg_classes", "")

 struct ddebug_class_user {
        const char *user_mod_name;
[jimc@frodo f2]$ make
....
  LD      vmlinux.o
  OBJCOPY modules.builtin.modinfo
  GEN     modules.builtin
  MODPOST Module.symvers
ERROR: modpost: Could not update namespace() for symbol map_disjoint_bits
ERROR: modpost: Could not update namespace() for symbol map_disjoint_names
ERROR: modpost: Could not update namespace() for symbol map_level_num
ERROR: modpost: Could not update namespace() for symbol map_level_names
ERROR: modpost: Could not update namespace() for symbol drm_debug_classes
ERROR: modpost: "map_level_names" [lib/test_dynamic_debug_submod.ko] undefined!
ERROR: modpost: "map_level_num" [lib/test_dynamic_debug_submod.ko] undefined!
ERROR: modpost: "map_disjoint_names"
[lib/test_dynamic_debug_submod.ko] undefined!
ERROR: modpost: "map_disjoint_bits" [lib/test_dynamic_debug_submod.ko]
undefined!
ERROR: modpost: "drm_debug_classes"
[drivers/gpu/drm/display/drm_display_helper.ko] undefined!
ERROR: modpost: "drm_debug_classes"
[drivers/gpu/drm/drm_kms_helper.ko] undefined!
ERROR: modpost: "drm_debug_classes"
[drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "drm_debug_classes" [drivers/gpu/drm/i915/i915.ko] undefined!
ERROR: modpost: "drm_debug_classes"
[drivers/gpu/drm/nouveau/nouveau.ko] undefined!
make[1]: *** [/home/jimc/projects/lx/wk-test/scripts/Makefile.modpost:126:
Module.symvers] Error 1
make: *** [/home/jimc/projects/lx/wk-test/Makefile:1944: modpost] Error 2
[jimc@frodo f2]$


Heres the relevant macros, including above change.

/**
 * DYNDBG_CLASSMAP_DEFINE - define the debug classes used in this module.
 * This tells dyndbg what debug classes it should control for the client.
 *
 * @_var:    struct ddebug_class_map, as passed to module_param_cb
 * @_type:   enum ddebug_class_map_type, chooses bits/verbose, numeric/symbolic
 * @classes: enum class values used in module, such as: DRM_UT_*
 */
#define DYNDBG_CLASSMAP_DEFINE(_var, _maptype, _base, ...)              \
        const char *_var##_classnames[] = {                             \
                iMAP_LIST(__stringify, _base, __VA_ARGS__) };           \
        struct ddebug_class_map __aligned(8) __used                     \
                __section("__dyndbg_classes") _var = {                  \
                .mod = THIS_MODULE,                                     \
                .mod_name = KBUILD_MODNAME,                             \
                .base = _base,                                          \
                .map_type = _maptype,                                   \
                .length = ARRAY_SIZE(_var##_classnames),                \
                .class_names = _var##_classnames,                       \
        };                                                              \
        __EXPORT_SYMBOL(_var, "__dyndbg_classes", "")

struct ddebug_class_user {
        const char *user_mod_name;
        const struct ddebug_class_map *map;
};
/**
 * DYNDBG_CLASSMAP_USE - refer to a classmap, DEFINEd elsewhere.
 * @_var: name of the exported classmap
 *
 * This registers the module's use of another module's classmap defn,
 * allowing dyndbg to find the controlling kparam, and propagate its
 * settings to the dependent module being loaded.
 */
#define DYNDBG_CLASSMAP_USE(_var)                                       \
        DYNDBG_CLASSMAP_USE_(_var, __UNIQUE_ID(ddebug_class_user))
#define DYNDBG_CLASSMAP_USE_(_var, _uname)                              \
        extern struct ddebug_class_map _var;                            \
        struct ddebug_class_user __used                                 \
        __section("__dyndbg_class_refs") _uname = {                     \
                .user_mod_name = KBUILD_MODNAME,                        \
                .map = &_var,                                           \
        }

Translating that for the skimmers -
_DEFINE creates a record in __dyndbg_classes section, exports it.
_USE creates a user-record, in __dyndbg_class_refs section,
which refs the 1st record.

plain old EXPORT_SYMBOL doesnt know the __dyndbg_classes section,
so users dont get it either, they somehow get new records,
which are "wrong" (have pointer to disallowed addr)full
The "ddebug_sanity" patch - 21/22 - isolates the problem linkage
to very early in dynamic_debug_init()


delving into the error itself, its from modpost.c:
static void sym_update_namespace(const char *symname, const char *namespace)

which is called from:
static void read_symbols(const char *modname)
...
        for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {
                symname = remove_dot(info.strtab + sym->st_name);

                /* Apply symbol namespaces from __kstrtabns_<symbol> entries. */
                if (strstarts(symname, "__kstrtabns_"))
                        sym_update_namespace(symname + strlen("__kstrtabns_"),
                                             sym_get_data(&info, sym));
        }

consulting git blame leads me to:

commit 69923208431e097ce3830647aee98e5bd3e889c8
Author: Matthias Maennich <maennich@google.com>
Date:   Fri Oct 18 10:31:42 2019 +0100

    symbol namespaces: revert to previous __ksymtab name scheme

    The introduction of Symbol Namespaces changed the naming schema of the
    __ksymtab entries from __kysmtab__symbol to __ksymtab_NAMESPACE.symbol.

    That caused some breakages in tools that depend on the name layout in
    either the binaries(vmlinux,*.ko) or in System.map. E.g. kmod's depmod
    would not be able to read System.map without a patch to support symbol
    namespaces. A warning reported by depmod for namespaced symbols would
    look like

      depmod: WARNING: [...]/uas.ko needs unknown symbol usb_stor_adjust_quirks

    In order to address this issue, revert to the original naming scheme and
    rather read the __kstrtabns_<symbol> entries and their corresponding
    values from __ksymtab_strings to update the namespace values for
    symbols. After having read all symbols and handled them in
    handle_modversions(), the symbols are created. In a second pass, read
    the __kstrtabns_ entries and update the namespaces accordingly.

    Fixes: 8651ec01daed ("module: add support for symbol namespaces.")
    Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
    Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
    Acked-by: Will Deacon <will@kernel.org>
    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
    Signed-off-by: Matthias Maennich <maennich@google.com>
    Signed-off-by: Jessica Yu <jeyu@kernel.org>


Im well out of my depth here, calling the experts

I think what I want is EXPORT_SYMBOL_FROM_SECTION ??
am I just doing it wrong ?
